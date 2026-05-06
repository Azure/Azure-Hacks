# Chapter 6 - Lab: Simple Terraform Deployment with GitHub

## Goal

The goal of this exercise is to...

- Get started with Terraform
- Create your first resources on Azure with Terraform


## Actions

## 1. Setting up your environment for this lab.

First, you will need to set up the required tools so can use Terraform and Visual Studio Code.

Open the Instructions in a new Browser tab and continue here, once you have finished the set up. [Setup instructions](../chapter-7/setup.md)

## 2. Create your first Azure resources with Terraform

In this step, you will work with similar resources that you alreay know from chapter 2. Only that this time you will not use the Azure Portal to create those resources in Azure but Terraform. In order to complete this chapter, you will need to review the [Terrafom documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs) and learn how to create the following resources. You can also use the "Learning resouces" listed below.

> [!CAUTION]
> Keep in mind, that you can continuosly test your Terraform code after every step. (`terraform plan`, `terraform apply`, `terraform destroy`)

### 2.1. Resource Group

- Make sure that your local folder is initialized as a Terraform project. All Terraform code should be placed in the `main.tf` file.
- Create a resource group. All resources you create in subsequent steps will be placed in this resource group and will typically be located in the same Azure region as the resource group.
- Use `swedencentral` as Azure region.
- Run the following Terraform commands:
  - `terraform init` (This will initialize the Terraform project)
  - `terraform plan` (This will show you what Terraform will do)
  - `terraform apply` (This will create the resources in Azure, if you confirm with `yes`)

### 2.2. Virtual Network

- Now, create a virtual network in the resource group and region. Use the following address space: `10.0.0.0/16`.
- Create a subnet in the virtual network. Use the following name `default` and address space: `10.0.1.0/24`.

> [!CAUTION]
> Keep in mind, that you can continuosly test your Terraform code after every step. (`terraform plan`, `terraform apply`)

### 2.3. Virtual Machine

#### 2.3.1. Public IP

- Create a public IP.
- Use the `Standard` SKU.
- Allow Azure to allocate the IP address statically.
- Place the IP address in your existing resource group in Sweden Central.

#### 2.3.2. Network Interface

- Create a network interface.
- Place the network interface in your existing resource group in Sweden Central.
- Create an IP configuration with dynamic IP allocation.
- Associate the network interface with the `default` subnet.
- Associate the previously created public IP with the network interface.

#### 2.3.3. Virtual Machine

- Create a Linux virtual machine.
- Place the VM in your existing resource group in Sweden Central.
- Assign the previously created network interface to the VM.
- Use `YWRtaW51c2VyC` as the admin username.
- Use the SSH key you have created previously.
- Use the size `Standard_B1s`.
- Use the following VM image:

Resource attribute         | Value
-------------------------- | ------
Publisher                  | `Canonical`
Offer                      | `0001-com-ubuntu-server-jammy`
Sku                        | `22_04-lts-gen2`
Version                    | `latest`

### 2.4. Network Security Group

- Create a network security group.
- Place the NSG in your existing resource group in Sweden Central.
- Associate the NSG with the previously created network interface.
- Create a rule that allows traffic to flow as follows:

Resource attribute         | Value
-------------------------- | ------
Name                       | `SSH`
Priority                   | `1000`
Direction                  | `Inbound`
Access                     | `Allow`
Protocol                   | `Tcp`
Source port range          | `*`
Destination port range     | `22`
Source address prefix      | `*`
Destination address prefix | `*`

### 2.5. Finally

- Make sure locally that your Terraform code is correct
- Deploy the resources to Azure using Terraform

### 2.6. Optional

- Test the SSH connection to the virtual machine. 
- Once you have verified that the resources have been created, remove the resources from Azure.

> [!CAUTION]
> Do not continue with the next step until you have verified that your local Terraform deployment succeeds.

### Learning resources

- [Quickstart: Create an Azure resource group using Terraform](https://learn.microsoft.com/en-us/azure/developer/terraform/create-resource-group?tabs=azure-cli)
- [Quickstart: Use Terraform to create a virtual network](https://learn.microsoft.com/en-us/azure/virtual-network/quick-create-terraform?tabs=azure-cli)
- [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)
- [azurerm_virtual_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)
- [azurerm_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)
- [azurerm_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip)
- [azurerm_network_security_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group)
- [azurerm_network_interface](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface)


### Learning resources

- [GitHub Action: login to Azure](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Clinux#use-the-azure-login-action-with-a-service-principal-secret)
- [GitHub Action: Terraform](https://github.com/azure-samples/terraform-github-actions/blob/main/.github/workflows/tf-plan-apply.yml)

## Success criteria

- You successfully created a Terraform Project
- You have created resources on Azure through Terraform
- You have removed the resources from Azure

## Continue

**[< back](../chapter-5/README.md) | [home](../../README.md) | [next >](../chapter-7/README.md) | [solutions](../../solutions/chapter-6/README.md)**