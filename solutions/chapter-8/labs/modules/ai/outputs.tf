output "aoai_endpoint"  {
  value = azurerm_cognitive_account.azure_oai.endpoint
}

# Note: API key auth is disabled in this environment (disableLocalAuth=true).
# Use Entra ID bearer tokens instead.