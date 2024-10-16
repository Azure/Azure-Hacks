using Azure.Messaging.EventHubs;
using Azure.Messaging.EventHubs.Consumer;
using Azure.Messaging.EventHubs.Processor;
using Azure.Storage.Blobs;
using Contonance.Backend.Clients;
using Contonance.Backend.Repositories;
using Contonance.Shared;
using Microsoft.Extensions.Configuration.AzureAppConfiguration;
using System.Collections.Concurrent;
using System.Text;
using System.Text.Json;

namespace Contonance.Backend.Background
{
    public class EventConsumer : IHostedService
    {
        private readonly IConfiguration _configuration;
        private readonly IConfigurationRefresher _refresher;
        private readonly RepairReportsRepository _repairReportsRepository;
        private readonly BlobServiceClient _blobServiceClient;
        private readonly EnterpriseWarehouseClient _enterpriseWarehouseClient;
        private readonly ILogger<EventConsumer> _logger;

        private EventProcessorClient _processor;

        private const int EventsBeforeCheckpoint = 2; // Just for demo purposes
        private ConcurrentDictionary<string, int> _partitionEventCount = new ConcurrentDictionary<string, int>();
        public EventConsumer(IConfiguration configuration,
                             RepairReportsRepository repairReportsRepository,
                             BlobServiceClient blobServiceClient,
                             EnterpriseWarehouseClient enterpriseWarehouseClient,
                             ILogger<EventConsumer> logger)
        {
            _configuration = configuration;
            _repairReportsRepository = repairReportsRepository;
            _blobServiceClient = blobServiceClient;
            _enterpriseWarehouseClient = enterpriseWarehouseClient;
            _logger = logger;
        }
        public EventConsumer(IConfiguration configuration,
                             IConfigurationRefresher refresher,
                             RepairReportsRepository repairReportsRepository,
                             BlobServiceClient blobServiceClient,
                             EnterpriseWarehouseClient enterpriseWarehouseClient,
                             ILogger<EventConsumer> logger)
        {
            _configuration = configuration;
            _refresher = refresher;
            _repairReportsRepository = repairReportsRepository;
            _blobServiceClient = blobServiceClient;
            _enterpriseWarehouseClient = enterpriseWarehouseClient;
            _logger = logger;
        }

        public async Task StartAsync(CancellationToken cancellationToken)
        {
            _logger.LogDebug($"EventConsumer is starting.");

            string consumerGroup = EventHubConsumerClient.DefaultConsumerGroupName;

            var eventHubName = _configuration.GetValue<string>("EventHub:EventHubName");
            var eventHubConnectionString = _configuration.GetValue<string>("EventHub:EventHubConnectionString");

            var blobContainerClient = _blobServiceClient.GetBlobContainerClient("checkpoint-store");
            await blobContainerClient.CreateIfNotExistsAsync();
            _processor = new EventProcessorClient(blobContainerClient, consumerGroup, eventHubConnectionString, eventHubName);

            _processor.ProcessEventAsync += ProcessEventHandler;
            _processor.ProcessErrorAsync += ProcessErrorHandler;

            await _processor.StartProcessingAsync();

            _logger.LogDebug($"EventConsumer started.");
        }

        public async Task StopAsync(CancellationToken cancellationToken)
        {
            _logger.LogDebug($"EventConsumer is stopping.");

            await _processor.StopProcessingAsync();
        }

        private async Task ProcessEventHandler(ProcessEventArgs arg)
        {
            try
            {
                if (arg.CancellationToken.IsCancellationRequested)
                {
                    return;
                }
             if (_refresher != null)
                {
                    await _refresher.RefreshAsync();
                }
                else
                {
                    _logger.LogWarning("ConfigurationRefresher is null");
                }
              //  await _refresher.RefreshAsync();

                _logger.LogTrace($"received message {arg.Data.MessageId}");
                var data = Encoding.UTF8.GetString(arg.Data.Body.ToArray());
                _logger.LogInformation(data);

                var repairReport = JsonSerializer.Deserialize<RepairReport>(data, new JsonSerializerOptions(JsonSerializerDefaults.Web))!;
                _repairReportsRepository.AddIfNew(repairReport);

                // For example: extract repair parts to order from the repairReport
                var sampleRepairPartId = Random.Shared.Next(100, 999);
                await _enterpriseWarehouseClient.OrderRepairPartAsync(sampleRepairPartId);


                // If the number of events that have been processed
                // since the last checkpoint was created exceeds the
                // checkpointing threshold, a new checkpoint will be
                // created and the count reset.
                string partition = arg.Partition.PartitionId;

                int eventsSinceLastCheckpoint = _partitionEventCount.AddOrUpdate(
                    key: partition,
                    addValue: 1,
                    updateValueFactory: (_, currentCount) => currentCount + 1);

                if (eventsSinceLastCheckpoint >= EventsBeforeCheckpoint)
                {
                    await arg.UpdateCheckpointAsync();
                    _partitionEventCount[partition] = 0;
                }
            }
            catch (System.Exception ex)
            {
                _logger.LogError(ex, "Error in ProcessEventHandler");
            }
        }

        private Task ProcessErrorHandler(ProcessErrorEventArgs arg)
        {
            _logger.LogError(arg.Exception, "exception while processing");

            return Task.CompletedTask;
        }
    }
}