# Configure the Microsoft Azure Provider.
# `storage_use_azuread = true` lets the provider talk to the storage
# data plane (containers, blobs, file shares, queues, tables) with the
# signed-in Entra ID identity instead of shared keys, which is required
# when the subscription disables `allowSharedKeyAccess` (default on most
# Microsoft-managed tenants).
provider "azurerm" {
  features {}
  storage_use_azuread = true
}

provider "random" {}
