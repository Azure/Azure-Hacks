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

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "${local.name_prefix}-vnet"
  address_space       = ["10.20.0.0/16"]
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
}

# Create a subnet for virtual machines
resource "azurerm_subnet" "subnet_1" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.lab.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.20.0.0/24"]
}

# Create a subnet for Kubernetes
resource "azurerm_subnet" "subnet_2" {
  name                 = "kubernetes"
  resource_group_name  = azurerm_resource_group.lab.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.20.1.0/24"]
}

# Create a subnet for PostgreSQL
resource "azurerm_subnet" "subnet_3" {
  name                 = "postgres"
  resource_group_name  = azurerm_resource_group.lab.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.20.2.0/24"]
  service_endpoints    = ["Microsoft.Storage"]

  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

# Create a public IP address for the jump host
resource "azurerm_public_ip" "vm_public_ip" {
  name                = "${local.name_prefix}-pip"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

// Associate the VM subnet with the network security group
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.subnet_1.id
  network_security_group_id = azurerm_network_security_group.lab_nsg.id
}

# Create Network Security Group and SSH rule
resource "azurerm_network_security_group" "lab_nsg" {
  name                = "${local.name_prefix}-nsg"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create a network interface for the jump host
resource "azurerm_network_interface" "vm_nic" {
  name                = "${local.name_prefix}-nic"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet_1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }
}

# Create the jump host
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "${local.name_prefix}-vm"
  computer_name       = "jumphost"
  resource_group_name = azurerm_resource_group.lab.name
  location            = azurerm_resource_group.lab.location
  size                = var.vm_size
  admin_username      = "YWRtaW51c2VyC"
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  admin_ssh_key {
    username   = "YWRtaW51c2VyC"
    public_key = file(var.ssh_key)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

# Create an Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                = "${replace(local.name_prefix, "-", "")}images"
  resource_group_name = azurerm_resource_group.lab.name
  location            = azurerm_resource_group.lab.location
  sku                 = "Basic"
  admin_enabled       = false
}

# Create an Azure Kubernetes Service cluster
resource "azurerm_kubernetes_cluster" "k8s" {
  location            = azurerm_resource_group.lab.location
  name                = "${local.name_prefix}-cluster"
  resource_group_name = azurerm_resource_group.lab.name
  dns_prefix          = "${local.name_prefix}-aks"
  kubernetes_version  = var.k8s_version

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name                = "agentpool1"
    vm_size             = "Standard_D2ads_v5"
    node_count          = 3
    zones               = ["1", "2", "3"]
    enable_auto_scaling = false
    os_disk_type        = "Ephemeral"
    os_disk_size_gb     = 70
    vnet_subnet_id      = azurerm_subnet.subnet_2.id
  }

  linux_profile {
    admin_username = "YWRtaW51c2VyC"

    ssh_key {
      key_data = file(var.ssh_key)
    }
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "azure"
    pod_cidr            = "192.168.0.0/16"
    load_balancer_sku   = "standard"
  }
}

# Create a role assignment for the AKS cluster to pull images from the ACR
resource "azurerm_role_assignment" "acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}
