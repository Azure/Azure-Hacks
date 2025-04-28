resource "random_pet" "resource_group_name" {
  length    = 2
  separator = "-"
}

resource "random_string" "storage_account_name" {
  length  = 24
  special = false
  upper   = false
}

resource "random_pet" "container_name" {
  length    = 2
  separator = "-"
}

resource "azurerm_resource_group" "example" {
  name     = random_pet.resource_group_name.id
  location = "East US"
}

resource "azurerm_storage_account" "example" {
  name                     = random_string.storage_account_name.result
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example" {
  name                  = random_pet.container_name.id
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}
