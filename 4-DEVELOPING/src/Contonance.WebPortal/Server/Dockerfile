FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS build
WORKDIR /source

COPY . .

WORKDIR /source/Contonance.WebPortal/Server
RUN dotnet restore
RUN dotnet clean
RUN dotnet publish -c release -o /app --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:7.0-alpine
EXPOSE 8080
ENV PORT=8080
ENV ASPNETCORE_URLS=http://+:8080
## backend url 
ENV CONTONANCE_BACKEND_URL=http://contonance-backend/
## Event hub config 
### See https://learn.microsoft.com/en-us/azure/event-hubs/event-hubs-create#create-an-event-hub)
### See https://learn.microsoft.com/en-us/azure/event-hubs/authorize-access-event-hubs
ENV EventHub__EventHubName=orders
ENV EventHub__EventHubConnectionString=
ENV ApplicationInsights__ConnectionString=
ENV AppConfiguration__ConnectionString=
ENV APP_VERSION=1.0.0
WORKDIR /app
COPY --from=build /app ./


#COPY --from=build /source/Contonance.WebPortal/Server/entrypoint.sh /entrypoint.sh
#RUN chmod +x /entrypoint.sh
# Use the startup script as the entry point
#ENTRYPOINT ["/entrypoint.sh"]


ENTRYPOINT ["dotnet", "Contonance.WebPortal.Server.dll"]

