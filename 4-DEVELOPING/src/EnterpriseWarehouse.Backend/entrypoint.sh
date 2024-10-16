#!/bin/sh
# Print out the names of the environment variables
echo "Expected environment variables:"
echo "PORT"
echo "ASPNETCORE_URLS"
echo "ENTERPRISE_WAREHOUSE_BACKEND_URL"
echo "ApplicationInsights__ConnectionString"
echo "ApplicationInsights__ConnectionString" 

# Start the application
exec dotnet EnterpriseWarehouse.Backend.dll