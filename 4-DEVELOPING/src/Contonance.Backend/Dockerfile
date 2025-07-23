FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS build
WORKDIR /source

# copy csproj and restore as distinct layers

COPY . .
WORKDIR /source/Contonance.Backend/
RUN dotnet restore
RUN dotnet publish -c release -o /app --self-contained false --no-restore

# Final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:7.0-alpine
EXPOSE 8080
ENV PORT=8080
ENV ASPNETCORE_URLS=http://+:8080
ENV ENTERPRISE_WAREHOUSE_BACKEND_URL=http://enterprise-warehouse-backend/api/message/receive
ENV EventHub__EventHubName=orders
## the following configs are required to be set 
ENV ApplicationInsights__ConnectionString=
ENV EventHub__EventHubConnectionString=
ENV EventHub__BlobConnectionString=
ENV AppConfiguration__ConnectionString=

WORKDIR /app
COPY --from=build /app ./
#COPY --from=build /source/Contonance.Backend/entrypoint.sh /entrypoint.sh

#RUN chmod +x /entrypoint.sh
# Use the startup script as the entry point
#ENTRYPOINT ["/entrypoint.sh"]
ENTRYPOINT ["dotnet", "Contonance.Backend.dll"]