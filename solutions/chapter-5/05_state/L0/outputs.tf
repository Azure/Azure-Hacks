output "resource_group_name" {
  value = azurerm_resource_group.example.name
}

# storage account
output "storage_account_name" {
  value = azurerm_storage_account.example.name
}

# storage container
output "storage_container_name" {
  value = azurerm_storage_container.example.name
}
