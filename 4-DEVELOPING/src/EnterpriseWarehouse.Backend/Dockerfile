FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY . .
WORKDIR /source/EnterpriseWarehouse.Backend/
RUN dotnet restore

RUN dotnet publish -c release -o /app --self-contained false --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:7.0-alpine
EXPOSE 8080
ENV PORT=8080
ENV ASPNETCORE_URLS=http://+:8080
ENV ConnectionStrings__CosmosApi=   
ENV ApplicationInsights__ConnectionString=
WORKDIR /app
COPY --from=build /app ./
#COPY --from=build /source/EnterpriseWarehouse.Backend/entrypoint.sh /entrypoint.sh

#RUN chmod +x /entrypoint.sh
#ENTRYPOINT ["/entrypoint.sh"]

ENTRYPOINT ["dotnet", "EnterpriseWarehouse.Backend.dll"]