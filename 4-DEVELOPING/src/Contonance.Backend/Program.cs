using Microsoft.ApplicationInsights.Extensibility;
using Microsoft.Extensions.Azure;
using Contonance.Backend.Background;
using Contonance.Backend.Clients;
using Contonance.Backend.Repositories;
using Contonance.Extensions;
using Microsoft.FeatureManagement;
using Microsoft.Extensions.Configuration.AzureAppConfiguration;

var builder = WebApplication.CreateBuilder(args);

IConfigurationRefresher? configurationRefresher = null;
builder.Configuration
    .AddJsonFile("appsettings.json")
    .AddEnvironmentVariables()
;
    var connectionString = builder.Configuration.GetValue<string>("AppConfiguration:ConnectionString");
if (!string.IsNullOrEmpty(connectionString))
{
    builder.Configuration.AddAzureAppConfiguration(options =>
    {
        options.Connect(connectionString)
            .UseFeatureFlags(options =>
            {
                options.CacheExpirationInterval = TimeSpan.FromSeconds(2);
            });
         configurationRefresher = options.GetRefresher();
    });
}

if (!string.IsNullOrEmpty(connectionString))
{
    builder.Services.AddSingleton(configurationRefresher);
}
builder.Services.AddControllers(options =>
{
    options.RespectBrowserAcceptHeader = true;
});

builder.Services.AddLogging(config =>
{
    config.AddDebug();
    config.AddConsole();
});

builder.Services.AddApplicationInsightsTelemetry(options =>
{
    options.DeveloperMode = true; // Only for demo purposes, do not use in production!
});
builder.Services.AddSingleton<ITelemetryInitializer>(_ => new CloudRoleNameTelemetryInitializer("Contonance.Backend"));

builder.Services.AddAzureClients(b =>
{
    b.AddBlobServiceClient(builder.Configuration.GetValue<string>("EventHub:BlobConnectionString"));
});

builder.Services.AddSingleton<RepairReportsRepository, RepairReportsRepository>();
builder.Services.AddSingleton<EnterpriseWarehouseClient, EnterpriseWarehouseClient>();

if (!string.IsNullOrEmpty(connectionString))
{
    builder.Services.AddAzureAppConfiguration();
    builder.Services.AddFeatureManagement();

}
builder.Services
    .AddHttpClient<EnterpriseWarehouseClient>()
    .AddPolicyConfiguration(EnterpriseWarehouseClient.SelectPolicy, builder.Configuration);


// Check if EventHub properties are set thern only start the EventConsumer. Hack to avoid running the EventConsumer in the WebPortal
string eventHubName = builder.Configuration.GetValue<string>("EventHub:EventHubName");
string eventHubConnectionString = builder.Configuration.GetValue<string>("EventHub:EventHubConnectionString");

if (!string.IsNullOrEmpty(eventHubName) && !string.IsNullOrEmpty(eventHubConnectionString))
{
    builder.Services.AddSingleton<IHostedService, EventConsumer>();
}


var app = builder.Build();

if (!string.IsNullOrEmpty(connectionString))
{
    app.UseAzureAppConfiguration();
}

app.MapControllers();

app.Run();