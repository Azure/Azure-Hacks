terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.1"
    }

    random = {
      source = "hashicorp/random"
    }

  }
}
