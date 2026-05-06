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
    public_key = var.ssh_key
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