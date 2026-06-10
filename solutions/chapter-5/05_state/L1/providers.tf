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

  # Remote backend in Azure Blob Storage.
  # Fill in the values produced by `terraform output` in the L0 module.
  # `use_azuread_auth = true` makes the backend use Entra ID (your `az login`
  # session) instead of shared keys; required when the storage account has
  # `shared_access_key_enabled = false` (default on Microsoft-managed tenants).
  backend "azurerm" {
    resource_group_name  = "REPLACE_WITH_L0_resource_group_name"
    storage_account_name = "REPLACE_WITH_L0_storage_account_name"
    container_name       = "REPLACE_WITH_L0_storage_container_name"
    key                  = "terraform.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {}
  storage_use_azuread = true
}

provider "random" {}
