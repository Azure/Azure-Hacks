# Caller identity is used to grant the user running terraform the data-plane
# role required to create the storage container with Entra ID auth.
data "azurerm_client_config" "current" {}

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
  location = "West Europe"
}

resource "azurerm_storage_account" "example" {
  name                            = random_string.storage_account_name.result
  resource_group_name             = azurerm_resource_group.example.name
  location                        = azurerm_resource_group.example.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  # Disable shared-key access. Required by the Defender for Storage policy
  # enforced on most Microsoft-managed tenants; setting it explicitly here
  # makes the resource idempotent (otherwise the policy modifies it after
  # creation and subsequent plans show drift).
  shared_access_key_enabled       = false
  default_to_oauth_authentication = true
}

# Grant the caller "Storage Blob Data Contributor" so the azurerm provider
# can create the container using Entra ID auth (no shared keys involved).
resource "azurerm_role_assignment" "blob_data_contributor" {
  scope                = azurerm_storage_account.example.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_storage_container" "example" {
  name                  = random_pet.container_name.id
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"

  # The role assignment must be in place before we attempt the data-plane
  # call that creates the container.
  depends_on = [azurerm_role_assignment.blob_data_contributor]
}
