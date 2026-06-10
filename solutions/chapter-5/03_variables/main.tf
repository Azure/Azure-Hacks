# Random suffix so two participants can run this lab side-by-side
# without bumping into the same resource group name.
resource "random_integer" "rg_suffix" {
  min = 1000
  max = 9999
}

locals {
  prefix              = "rg"
  resource_group_name = "${local.prefix}-${var.resource_group_name}-${random_integer.rg_suffix.result}"
}

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.resource_group_location
}

