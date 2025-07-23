# Variables
export RESOURCE_GROUP=rg-bmwhack-12
export APP_INSIGHTS_NAME="appinsights-bmwhack-12"
export NAMESPACE_NAME="eh-bmwhack-12"
export EVENTHUB_NAME="orders"

export  STORAGE_ACCOUNT_NAME="storagebmwhack12"
export APPCONFIG_NAME=appconfig-bmwhack-12



# Retrieve Application Insights Connection String
app_insights_connection_string=$(az monitor app-insights component show --app $APP_INSIGHTS_NAME --resource-group $RESOURCE_GROUP --query "connectionString" --output tsv)

# Retrieve Event Hub Connection String
event_hub_connection_string=$(az eventhubs eventhub authorization-rule keys list --resource-group $RESOURCE_GROUP --namespace-name $NAMESPACE_NAME --eventhub-name $EVENTHUB_NAME --authorization-rule-name=listensend --query "primaryConnectionString" --output tsv)
# Retrieve Blob Storage Connection String
blob_connection_string=$(az storage account show-connection-string --name $STORAGE_ACCOUNT_NAME --resource-group $RESOURCE_GROUP --query "connectionString" --output tsv)
# Retrieve App Configuration Connection String
app_config_connection_string=$(az appconfig credential list --resource-group $RESOURCE_GROUP --name $APPCONFIG_NAME --query "[0].connectionString" --output tsv)
# Set environment variables
export ApplicationInsights__ConnectionString=$app_insights_connection_string
export EventHub__EventHubConnectionString=$event_hub_connection_string
export EventHub__BlobConnectionString=$blob_connection_string
export AppConfiguration__ConnectionString=$app_config_connection_string
# Write environment variables to .env file
cat <<EOL > .env
ApplicationInsights__ConnectionString=$ApplicationInsights__ConnectionString
EventHub__EventHubConnectionString=$EventHub__EventHubConnectionString
EventHub__BlobConnectionString=$EventHub__BlobConnectionString
AppConfiguration__ConnectionString=$AppConfiguration__ConnectionString
CONTONANCE_BACKEND_URL=http://contonance-backend/
ENTERPRISE_WAREHOUSE_BACKEND_URL=http://enterprise-warehouse-backend/api/message/receive
EventHub__EventHubName=events
ConnectionStrings__CosmosApi=AccountEndpoint=https://bmwhack12.documents.azure.com:443/;Account

EOL
# Print the environment variables to verify
echo "ApplicationInsights__ConnectionString=$ApplicationInsights__ConnectionString"
echo "EventHub__EventHubConnectionString=$EventHub__EventHubConnectionString"
echo "EventHub__BlobConnectionString=$EventHub__BlobConnectionString"
echo "AppConfiguration__ConnectionString=$AppConfiguration__ConnectionString" 
echo ""
echo "add to az containerapp create command the following "
echo "--env-vars ApplicationInsights__ConnectionString=$ApplicationInsights__ConnectionString EventHub__EventHubConnectionString=$EventHub__EventHubConnectionString EventHub__BlobConnectionString=$EventHub__BlobConnectionString AppConfiguration__ConnectionString=$AppConfiguration__ConnectionString"