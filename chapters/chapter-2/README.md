# Chapter 2 - Theory & Lab: VNet, VMs and Azure Portal

## Goal

This chapter is all about learning about Virtual Networks, Virtual Machines, and Azure Portal. You will learn how to create and manage Virtual Networks, Virtual Machines, and other resources in Azure:

- Introduction into Azure Portal
- Create and explain a VNET
- Create and explain a VM with Disk(s) and Public IP & Bastion, NSG (SSH Keys, Credential)

## Theory

> [!CAUTION]
> For all the following topics there are slides available for the instructor:
> - [Azure Virtual Network](https://microsofteur-my.sharepoint.com/:p:/g/personal/joergjo_microsoft_com/EVHMQ0ucXChAlIAftPJ2jswB_GXWEqCzaaFbCGpXLz4Ynw?e=w3zw8O)
> - [Azure Virtual Machine](https://microsofteur-my.sharepoint.com/:p:/g/personal/joergjo_microsoft_com/ET7XuWLkqWJMsWDTlUi0HzIBssxAZFGEq9dtAgqkh9nTuA?e=ImXb7P)

### Virtual Network (VNet)

A Virtual Network (VNet) is a representation of your own network in the cloud. It is a logical isolation of the Azure cloud dedicated to your subscription. You can securely connect Azure resources to each other with VNets, extend your on-premises network to Azure, and filter outbound internet traffic.

#### Public IP Address

A public IP address is a globally unique IP address that is reachable from the internet. You can associate a public IP address with a VM to enable communication with the internet. Azure provides dynamic and static public IP addresses.

#### Bastion

Azure Bastion is a fully managed PaaS service that provides secure and seamless RDP and SSH access to your VMs directly through the Azure Portal. Azure Bastion is provisioned directly in your VNet and supports all VMs in your VNet using SSL without any exposure through public IP addresses.

#### Network Security Group (NSG)

A Network Security Group (NSG) contains a list of security rules that allow or deny inbound or outbound network traffic to resources connected to an Azure Virtual Network. NSGs can be associated with subnets, individual VMs, or both. NSGs are used to filter network traffic to and from Azure resources in an Azure Virtual Network.

### Virtual Machine (VM)

A Virtual Machine (VM) is a software computer that, like a physical computer, runs an operating system and applications. The VM consists of several components, such as disks, network interfaces, and extensions. You can create and manage VMs in the Azure Portal.

#### Disk

A disk is a virtual hard drive that stores the operating system, applications, and data. Azure provides different types of disks, such as managed disks, unmanaged disks, and shared disks. Managed disks are the recommended disk storage option for VMs.

#### Virtual Machine Scale Sets

Virtual Machine Scale Sets let you create and manage a group of identical, load-balanced VMs. The number of VM instances can automatically increase or decrease in response to demand or a defined schedule. Scale sets provide high availability to your applications, and allow you to centrally manage, configure, and update a large number of VMs.

## Showcasing these resources in Azure Portal

> [!CAUTION]
> You can use Terraform to create the resources in Azure. The Terraform code is available in the **[solutions](../../solutions/chapter-2/README.md) folder**.
> The Terraform is not generic and NOT enterprise ready and is just used to deploy the resources in your subscription to easily click through them.

## Labs

### Virtual Network

> [!CAUTION]
> Please follow the instructions in this lab: https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/Instructions/Labs/LAB_04-Implement_Virtual_Networking.html

### Virtual Machine and Virtual Machine Scale Sets

> [!CAUTION]
> Please follow the instructions in this lab: https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/Instructions/Labs/LAB_08-Manage_Virtual_Machines.html

### Virtual Machine and install a small web server 

> [!CAUTION]
> Please follow the instructions in this lab - **Exercise 1**: https://mslearn.cloudguides.com/en-us/guides/AZ-900%20Exam%20Guide%20-%20Azure%20Fundamentals%20Exercise%201

### Advanced: Use PaaS App Service instead of VM
> [!CAUTION]
> Please follow the instructions in this lab - **Exercise 2**: https://mslearn.cloudguides.com/en-us/guides/AZ-900%20Exam%20Guide%20-%20Azure%20Fundamentals%20Exercise%202

## Learning resources

- About Virtual machines and Virtual Machine Scale Sets: https://youtu.be/OykMc6wKMJY

## Continue

**[< back](../chapter-1/README.md) | [home](../../README.md) | [next >](../chapter-3/README.md) | [solutions](../../solutions/chapter-2/README.md)**
