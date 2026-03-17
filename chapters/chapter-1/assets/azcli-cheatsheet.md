# Azure CLI Cheat Sheet 🚀

| Category            | Command                                                                                   | Description                                           |
|---------------------|-------------------------------------------------------------------------------------------|-------------------------------------------------------|
| **General** 🌍      | `az login`                                                                                | Login to Azure                                        |
|                     | `az account list --output table`                                                          | List all Azure subscriptions                          |
|                     | `az account set --subscription "<subscription_id>"`                                       | Set a default subscription                           |
| **Resource Groups** 📁 | `az group create --name <ResourceGroupName> --location <Location>`                        | Create a resource group                               |
|                     | `az group list --output table`                                                            | List resource groups                                  |
|                     | `az group delete --name <ResourceGroupName>`                                              | Delete a resource group                               |
| **Virtual Machines** 💻 | `az vm create --resource-group <ResourceGroupName> --name <VMName> --image UbuntuLTS --generate-ssh-keys` | Create a VM |
|                     | `az vm start --resource-group <ResourceGroupName> --name <VMName>`                        | Start a VM                                            |
|                     | `az vm stop --resource-group <ResourceGroupName> --name <VMName>`                         | Stop a VM                                             |
|                     | `az vm list --output table`                                                               | List all VMs                                          |
| **Storage Accounts** 📦 | `az storage account create --name <StorageAccountName> --resource-group <ResourceGroupName> --location <Location> --sku Standard_LRS` | Create a storage account |
|                     | `az storage account list --output table`                                                  | List storage accounts                                 |
|                     | `az storage account delete --name <StorageAccountName> --resource-group <ResourceGroupName>` | Delete a storage account |
| **Web Apps** 🌐      | `az webapp create --resource-group <ResourceGroupName> --plan <AppServicePlan> --name <WebAppName>` | Create a web app |
|                     | `az webapp list --output table`                                                           | List web apps                                         |
|                     | `az webapp stop --name <WebAppName> --resource-group <ResourceGroupName>`                 | Stop a web app                                        |
|                     | `az webapp start --name <WebAppName> --resource-group <ResourceGroupName>`                | Start a web app                                       |
| **Databases** 🗄️     | **Azure SQL Database**                                                                    |                                                       |
|                     | `az sql db create --resource-group <ResourceGroupName> --server <ServerName> --name <DatabaseName> --service-objective S0` | Create a SQL database |
|                     | `az sql db list --server <ServerName> --output table`                                     | List SQL databases                                    |
|                     | `az sql db delete --name <DatabaseName> --server <ServerName> --resource-group <ResourceGroupName>` | Delete a SQL database |
|                     | **Cosmos DB** 🌌                                                                           |                                                       |
|                     | `az cosmosdb create --name <AccountName> --resource-group <ResourceGroupName> --kind GlobalDocumentDB` | Create a Cosmos DB account |
|                     | `az cosmosdb list --output table`                                                         | List Cosmos DB accounts                               |
|                     | `az cosmosdb delete --name <AccountName> --resource-group <ResourceGroupName>`            | Delete a Cosmos DB account                            |
| **Networking** 🌐    | `az network vnet create --resource-group <ResourceGroupName> --name <VNetName> --subnet-name <SubnetName>` | Create a virtual network |
|                     | `az network vnet list --output table`                                                     | List virtual networks                                 |
|                     | `az network vnet delete --name <VNetName> --resource-group <ResourceGroupName>`           | Delete a virtual network                              |
| **AKS** 🚢           | `az aks create --resource-group <ResourceGroupName> --name <ClusterName> --node-count 1 --enable-addons monitoring --generate-ssh-keys` | Create an AKS cluster |
|                     | `az aks get-credentials --resource-group <ResourceGroupName> --name <ClusterName>`        | Get credentials for AKS cluster                       |
|                     | `az aks list --output table`                                                              | List AKS clusters                                     |