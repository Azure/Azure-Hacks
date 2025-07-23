#!/bin/sh

# Check for mandatory environment variables
#: "${PORT:?Environment variable PORT is required}"
#: "${ASPNETCORE_URLS:?Environment variable ASPNETCORE_URLS is required}"#
#: "${CONTONANCE_BACKEND_URL:?Environment variable CONTONANCE_BACKEND_URL is required}"
#: "${ApplicationInsights__ConnectionString:?Environment variable ApplicationInsights__ConnectionString is required}"
#: "${EventHub__EventHubName:?Environment variable EventHub__EventHubName is required}"
#: "${EventHub__EventHubConnectionString:?Environment variable EventHub__EventHubConnectionString is required}"
#: "${EventHub__BlobConnectionString:?Environment variable EventHub__BlobConnectionString is required}"
#: "${AppConfiguration__ConnectionString:?Environment variable AppConfiguration__ConnectionString is required}"
#: "${AzureBlobContainerUrl:?Environment variable AzureBlobContainerUrl is required}"
#: "${AzureBlobSasToken:?Environment variable AzureBlobSasToken is required}"
## 
# Print the environment variable names
echo "Environment variables: for Contonance.WebPortal.Server"
echo "PORT"
echo "ASPNETCORE_URLS"
echo "CONTONANCE_BACKEND_URL"
echo "ApplicationInsights__ConnectionString"
echo "EventHub__EventHubName"
echo "EventHub__EventHubConnectionString"
echo "EventHub__BlobConnectionString"
echo "AppConfiguration__ConnectionString"
echo "AzureBlobContainerUrl"
echo "AzureBlobSasToken"
# Start the application
exec dotnet Contonance.WebPortal.Server.dll