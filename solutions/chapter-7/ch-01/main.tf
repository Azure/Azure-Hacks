# Create a random string to distinguish names that are FQDNs
resource "random_integer" "uid" {
  min = 1000
  max = 9999
}

# Create a local variable to store the name prefix
locals {
  name_prefix = "${var.base_prefix}-${random_integer.uid.id}"
}

# Create a resource group
resource "azurerm_resource_group" "lab" {
  name     = local.name_prefix
  location = var.location

  tags = {
    environment = "Terraform and Azure Lab"
    # Replace with your own value
    owner       = "YWRtaW51c2VyC"
  }
}