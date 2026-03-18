# Create a random string to distinguish names that are FQDNs
resource "random_integer" "uid" {
  min = 1000
  max = 9999
}

# Create a random password for the PostgreSQL server
resource "random_password" "pg_password" {
  length           = 20
  special          = true
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  override_special = "_-"
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
    owner       = "YWRtaW51c2VyC"
  }
}

# Modules

module "network" {
  source              = "./modules/network"
  vnet_name           = "${local.name_prefix}-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.lab.name
}

module "compute" {
  source              = "./modules/compute"
  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.lab.name
  subnet_id           = module.network.subnet_1_name
  ssh_key             = var.ssh_key
  vm_size             = var.vm_size
}

module "k8s" {
  source              = "./modules/k8s"
  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.lab.name
  k8s_version         = var.k8s_version
  subnet_id           = module.network.subnet_2_name
  ssh_key             = var.ssh_key  
}

module "db" {
  source              = "./modules/db"
  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.lab.name
  vnet_id             = module.network.vnet_id
  subnet_id           = module.network.subnet_3_name
  pg_password         = random_password.pg_password.result
}

module "ai" {
  source              = "./modules/ai"
  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.lab.name
  aoai_model_name     = var.aoai_model_name
  aoai_model_version  = var.aoai_model_version
}
