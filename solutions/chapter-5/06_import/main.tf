# Baseline: a single resource group with a random name. The participant
# will create one additional resource (an Azure Storage Account) inside
# this resource group using the Azure CLI, and then bring it under
# Terraform management with `terraform import` — see README.md.

resource "random_pet" "resource_group_name" {
  length    = 2
  separator = "-"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-import-${random_pet.resource_group_name.id}"
  location = "West Europe"
}

# After the import the resource will look something like:
#
# resource "azurerm_storage_account" "imported" {
#   name                     = "<the name you picked>"
#   resource_group_name      = azurerm_resource_group.rg.name
#   location                 = azurerm_resource_group.rg.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }
