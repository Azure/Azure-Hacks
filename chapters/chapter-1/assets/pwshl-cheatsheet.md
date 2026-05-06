# PowerShell Cheat Sheet for Azure DevOps Engineers 🚀

| Category                | Command                                                                                   | Description                                           |
|-------------------------|-------------------------------------------------------------------------------------------|-------------------------------------------------------|
| **General** 🌐          | `Install-Module Az`                                                                       | Install the Azure PowerShell module                   |
|                         | `Connect-AzAccount`                                                                       | Login to Azure                                        |
|                         | `Get-AzSubscription`                                                                      | Show all Azure subscriptions                          |
|                         | `Set-AzContext -Subscription <subscription-id>`                                           | Set the default Azure subscription                    |
| **Resource Groups** 📁  | `Get-AzResourceGroup`                                                                     | Show all Azure resource groups                        |
|                         | `New-AzResourceGroup -Name <name> -Location <location>`                                   | Create a new Azure resource group                     |
|                         | `Remove-AzResourceGroup -Name <name>`                                                     | Delete an Azure resource group                        |
| **Resources** 🛠️        | `Get-AzResource -ResourceGroupName <resource-group-name>`                                 | Show all resources in a specific resource group       |
|                         | `New-AzResource -ResourceGroupName <resource-group-name> -ResourceType <resource-type> -Name <name> -Location <location>` | Create a new resource in a resource group             |
|                         | `Remove-AzResource -ResourceId <resource-id>`                                             | Delete a resource by its ID                           |
| **Virtual Machines** 💻 | `Get-AzVM -ResourceGroupName <resource-group-name>`                                       | List all VMs in a resource group                      |
|                         | `New-AzVM -ResourceGroupName <resource-group-name> -Name <vm-name>`                       | Create a new VM in a resource group                   |
|                         | `Stop-AzVM -ResourceGroupName <resource-group-name> -Name <vm-name>`                      | Stop a VM                                             |
|                         | `Start-AzVM -ResourceGroupName <resource-group-name> -Name <vm-name>`                     | Start a VM                                            |
| **Storage** 📦           | `Get-AzStorageAccount -ResourceGroupName <resource-group-name>`                           | List all storage accounts in a resource group         |
|                         | `New-AzStorageAccount -ResourceGroupName <resource-group-name> -Name <account-name> -Location <location> -SkuName <sku>` | Create a new storage account                          |
|                         | `Remove-AzStorageAccount -ResourceGroupName <resource-group-name> -Name <account-name>`   | Delete a storage account                              |
| **Networking** 🌍       | `Get-AzVirtualNetwork -ResourceGroupName <resource-group-name>`                           | List all virtual networks in a resource group         |
|                         | `New-AzVirtualNetwork -ResourceGroupName <resource-group-name> -Location <location> -Name <vnet-name>` | Create a new virtual network                          |
|                         | `Remove-AzVirtualNetwork -Name <vnet-name> -ResourceGroupName <resource-group-name>`       | Delete a virtual network                              |

This cheat sheet provides a quick reference to the most common PowerShell commands for Azure DevOps engineers, with emojis for better readability and enjoyment! 🌟