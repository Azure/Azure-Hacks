output "aoai_endpoint"  {
  value = azurerm_cognitive_account.azure_oai.endpoint
}

output "aoai_key" {
  value = azurerm_cognitive_account.azure_oai.primary_access_key
  sensitive = true
}