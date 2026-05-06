resource "azurerm_cognitive_account" "azure_oai" {
  name                  = "${var.name_prefix}-aoai"
  location              = var.location
  resource_group_name   = var.resource_group_name
  kind                  = "OpenAI"
  sku_name              = "S0"
  custom_subdomain_name = "${var.name_prefix}-aoai"
}

resource "azurerm_cognitive_deployment" "gpt_4o_mini" {
  name                 = var.aoai_model_name
  cognitive_account_id = azurerm_cognitive_account.azure_oai.id

  model {
    format  = "OpenAI"
    name    = var.aoai_model_name
    version = var.aoai_model_version
  }

  scale {
    type     = "Standard"
    capacity = 20
  }
}