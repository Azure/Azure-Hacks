provider "azurerm" {
  features {}

}

provider "random" {}


resource "random_pet" "rg_random_name" {
  length    = 2
  separator = "-"
}

resource "azurerm_resource_group" "resource_group" {
  name     = "rg-${random_pet.rg_random_name.id}"
  location = "West Europe"

}

module "avm-res-network-virtualnetwork" {
  source = "Azure/avm-res-network-virtualnetwork/azurerm"

  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  name = "vnet1"

  subnets = {
    "subnet1" = {
      name             = "subnet1"
      address_prefixes = ["10.0.0.0/24"]
    }
    "subnet2" = {
      name             = "subnet2"
      address_prefixes = ["10.0.1.0/24"]
    }
  }
}
