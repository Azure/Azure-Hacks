# Configure the Microsoft Azure Provider.
# `storage_use_azuread = true` makes the provider use Entra ID (Azure AD) for
# storage data-plane operations (containers, blobs, queues, file shares).
# This is required when the subscription has a security policy that disables
# shared-key access on storage accounts (allowSharedKeyAccess = false), which
# is the default in many Microsoft-managed / CloudAcademy tenants.
provider "azurerm" {
  features {}
  storage_use_azuread = true
}

provider "random" {}
