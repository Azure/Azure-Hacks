output "resource_group_name" {
  description = "Name of the baseline resource group. Create the storage account to be imported inside this resource group."
  value       = azurerm_resource_group.rg.name
}

output "resource_group_id" {
  description = "Full Azure resource ID of the baseline resource group."
  value       = azurerm_resource_group.rg.id
}
