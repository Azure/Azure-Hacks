
# Generate a random integer
resource "random_integer" "rg_suffix" {
  min = 1000
  max = 9999
}
# Locals to add prefix to resource group name
locals {
  prefix = "rg"
}

# Final resource group name as local
locals {
  resource_group_name = "${local.prefix}-${var.resource_group_name}-${random_integer.rg_suffix.result}"
}

# best practice is to lowercase the resource group name with the built-in lower() function
# locals {
#   resource_group_name = lower("${local.prefix}-${var.resource_group_name}")
# }

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.resource_group_location
}