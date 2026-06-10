terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "azurerm" {
  features {}
}

# Short random suffix so two participants can run this lab side-by-side
# without bumping into each other on resource group names.
resource "random_pet" "id" {
  length    = 2
  separator = "-"
}

resource "azurerm_resource_group" "example" {
  name     = "rg-intro-${random_pet.id.id}"
  location = "West Europe"
}

output "resource_group_name" {
  value = azurerm_resource_group.example.name
}
