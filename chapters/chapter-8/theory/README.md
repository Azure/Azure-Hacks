# Chapter 8 - Terraform modularization (Modular Deployments)

## Goal

This chapter is mostly instructor led. The goal is to introduce the concept of modularization in Terraform. This is a key concept in Terraform that allows you to break down your infrastructure into smaller, reusable components. 
In addition to this we will show Microsofts approach to modularization in Terraform by using the [Azure Verified modules](https://azure.github.io/Azure-Verified-Modules/#:~:text=Azure%20Verified%20Modules%20%28AVM%29%20is%20an%20initiative%20to,and%20available%20from%20their%20respective%20language%20specific%20registries.).

## Terraform Modules

> [!CAUTION]
> Please use the slides to explain the concept of Terraform modules: https://microsofteur-my.sharepoint.com/:p:/g/personal/joergjo_microsoft_com/EeK5S2BZyuRFu1kN-t9ICuEBPcywO-wWjh9YcKepB9tEQQ?e=N9JFpU
> The chapter "Terraform Modules" is needed.

### Demos

> [!CAUTION]
> Please use the following demos to showcase the concept of Terraform modules, that can be found in the solutions [folder](../../../solutions/chapter-8/theory).
> Within these slides modules are explained and how to use them in Terraform.

#### Terraform modules local

You can use this demo to showcase how to create a local module in Terraform.
The module is a refactoring of [main.tf](../../../solutions/chapter-2/terraform-deployment/main.tf).

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.111.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "example_vnet" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example_subnet" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  
}

resource "azurerm_network_interface" "example_nic" {
  name                = "example-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example_public_ip.id
  }
}

resource "azurerm_public_ip" "example_public_ip" {
  name                = "example-publicip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Dynamic"
}

resource "azurerm_linux_virtual_machine" "example_vm" {
  name                = "example-vm"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_B1s"
  admin_username      = "YWRtaW51c2VyC"
  network_interface_ids = [
    azurerm_network_interface.example_nic.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  admin_ssh_key {
    username   = "YWRtaW51c2VyC"
    public_key = file("~/.ssh/id_rsa.pub")
  }
  disable_password_authentication = true
}

resource "azurerm_network_security_group" "example_nsg" {
  name                = "example-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = "SSH"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example.name
  network_security_group_name = azurerm_network_security_group.example_nsg.name
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.example_nic.id
  network_security_group_id = azurerm_network_security_group.example_nsg.id
}
```

It is important to explain the audience the use of modules, the structure of modules, and the benefits of modules. Go through the newly created module found in the solutions [folder](../../../solutions/chapter-8/theory/terraform-modules-local/modules/module-vm-vnet) and explain the process of refactoring the code into a module.

One important note is the how to use this created module in the main.tf file. This can be done by using the module block in the main.tf file:

```hcl
module "module-vm-vnet" {
  source = "./modules/module-vm-vnet"
}
```

There might come up questions if the module can be outsourced in version control and consumed from there. This is a good point to introduce the next demo.

#### Terraform modules git private

You can use this demo to showcase how to create a remote module in Terraform hosted on Github.
For the sake of simplicity, the module is a refactoring of the previous module in the local demo.

The most important part is that the local module has been removed and instead there is a module block that points to the Github repository:
```hcl
module "small_landing_zone" {

  source              = "git::https://jeffreygroneberg:<github_pat>@github.com/timoknapp/az-training-workshops.git//solutions/chapter-8/terraform-modules-local/modules/module-vm-vnet"
  ssh_public_key      = file("~/.ssh/id_rsa.pub")
  resource_group_name = "small-landing-zone"
  location            = "West Europe"
  vnet_address_space  = "10.0.0.0/16"

  providers = {
    azurerm = azurerm
  }
}
```

> [!CAUTION]
> You need a PAT that is working with the private remote location. It makes sense to fork the training repository and use your own PAT by going to the developer settings in Github following this link https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token
> This PAT can be used to replace the `<github_pat>` in the module block.

## Azure Verified Modules

> [!CAUTION]
> Please use the slides to explain the concept of Azure Verified modules: https://microsofteur-my.sharepoint.com/:p:/g/personal/joergjo_microsoft_com/EeK5S2BZyuRFu1kN-t9ICuEBPcywO-wWjh9YcKepB9tEQQ?e=N9JFpU
> The chapter "Azure Verified Module" is needed.

For the demo we pick one simple module out of: https://azure.github.io/Azure-Verified-Modules/indexes/terraform/tf-resource-modules/#published-modules-----
    
You can use [this repository](../../../solutions/chapter-8/theory/azure-verified-module) to showcase how to deploy a small Verified Azure Module.

## Best Pracices

https://azure.github.io/Azure-Verified-Modules/specs/shared/
https://azure.github.io/Azure-Verified-Modules/specs/terraform/

## Learning resources

- Creating modules: https://developer.hashicorp.com/terraform/language/modules/develop
- Best practice about creating modules: https://www.youtube.com/watch?v=bDVr7RNlPsQ&ab_channel=HashiCorp
- Azure Verified Modules: https://www.youtube.com/watch?v=3FeIFHaJOtg&ab_channel=JohnSavill%27sTechnicalTraining
- AVM Lab: https://learn.microsoft.com/en-us/samples/azure-samples/avm-terraform-labs/avm-terraform-labs/

## Continue

**[< back](../README.md) | [home](../../README.md) | [next >](../labs/README.md) | [solutions](../../../solutions/chapter-8/theory/README.md)**
