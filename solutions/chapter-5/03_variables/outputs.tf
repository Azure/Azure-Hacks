output "resource_group_id" {
  description = "Full Azure resource ID of the resource group."
  value       = azurerm_resource_group.rg.id
}

output "resource_group_name" {
  description = "Name of the resource group that was created."
  value       = azurerm_resource_group.rg.name
}
