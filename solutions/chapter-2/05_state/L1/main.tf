resource "random_pet" "resource_group_name" {
  length    = 2
  separator = "-"
}

resource "azurerm_resource_group" "example" {
  name     = "rg-${random_pet.resource_group_name.id}"
  location = "West Europe"
}
