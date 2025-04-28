# Chapter 1 - Lab: VNet, VMs and Azure Portal

## Goal

This chapter is all about learning about Azure Fundamentals such as: Virtual Networks, Virtual Machines, Azure Portal and Role Assignment. You will learn how to create and manage Virtual Networks, Virtual Machines, and other resources in Azure.

In this chapter we will cover the following topics:

- Role Assignment for a resource
- Introduction into Azure Portal
- Create and explain a VNet, VM, NSG
- Create and explain a VM with Disk(s)
- Advanced Lab: Use PaaS App Service instead of Virtual Machines

## Theory

> [!CAUTION]
> For all the following topics there are slides available for the instructor:
>
> - [Azure Virtual Network](https://microsofteur-my.sharepoint.com/:p:/g/personal/joergjo_microsoft_com/EVHMQ0ucXChAlIAftPJ2jswB_GXWEqCzaaFbCGpXLz4Ynw?e=w3zw8O)
> - [Azure Virtual Machine](https://microsofteur-my.sharepoint.com/:p:/g/personal/joergjo_microsoft_com/ET7XuWLkqWJMsWDTlUi0HzIBssxAZFGEq9dtAgqkh9nTuA?e=ImXb7P)

### Role Assignment (RBAC)

Role-based access control (RBAC) in Azure allows you to manage who has access to Azure resources, what they can do with those resources, and what areas they have access to. Role assignments are a key part of RBAC.

A role assignment consists of three elements:

1. **Security Principal**: This can be a user, group, service principal, or managed identity.
2. **Role Definition**: A collection of permissions, such as "Reader," "Contributor," or "Owner."
3. **Scope**: The level at which access applies, such as a subscription, resource group, or specific resource.

To assign a role:

1. Identify the resource you want to secure.
2. Choose the appropriate role definition.
3. Assign the role to a security principal at the desired scope.

> [!NOTE]
> Use the principle of least privilege when assigning roles to ensure users only have the permissions they need.

For more details, refer to the official documentation: [Azure RBAC](https://learn.microsoft.com/en-us/azure/role-based-access-control/overview).

### Virtual Network (VNet)

A Virtual Network (VNet) is a representation of your own network in the cloud. It is a logical isolation of the Azure cloud dedicated to your subscription. You can securely connect Azure resources to each other with VNets, extend your on-premises network to Azure, and filter outbound internet traffic.

### Network Security Group (NSG)s

A Network Security Group (NSG) contains a list of security rules that allow or deny inbound or outbound network traffic to resources connected to an Azure Virtual Network. NSGs can be associated with subnets, individual VMs, or both. NSGs are used to filter network traffic to and from Azure resources in an Azure Virtual Network.

### Virtual Machine (VM)

A Virtual Machine (VM) is a software computer that, like a physical computer, runs an operating system and applications. The VM consists of several components, such as disks, network interfaces, and extensions. You can create and manage VMs in the Azure Portal.

#### Disk

A disk is a virtual hard drive that stores the operating system, applications, and data. Azure provides different types of disks, such as managed disks, unmanaged disks, and shared disks. Managed disks are the recommended disk storage option for VMs.

#### Virtual Machine Scale Sets

Virtual Machine Scale Sets let you create and manage a group of identical, load-balanced VMs. The number of VM instances can automatically increase or decrease in response to demand or a defined schedule. Scale sets provide high availability to your applications, and allow you to centrally manage, configure, and update a large number of VMs.

## Labs

### Role Assignment

> [!IMPORTANT]
> Please follow the instructions in this lab: <https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments-portal>

#### Lab Steps

1. Navigate to the Azure Portal.
2. Select the resource (e.g., a Virtual Machine or Resource Group) for which you want to assign a role.
3. Go to the **Access control (IAM)** section.
4. Click **Add** > **Add role assignment**.
5. Select a role (e.g., "Reader" or "Contributor").
6. Assign the role to a user, group, or service principal.
7. Save the changes and verify the role assignment.

> [!TIP]
> Use the Azure CLI for automation:

```bash
az role assignment create --assignee <user-email-or-object-id> --role <role-name> --scope <resource-scope>
```

### Virtual Network

> [!IMPORTANT]
> Please follow the instructions in this lab: <https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/Instructions/Labs/LAB_04-Implement_Virtual_Networking.html>

### Virtual Machine and Virtual Machine Scale Sets

> [!IMPORTANT]
> Please follow the instructions in this lab: <https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/Instructions/Labs/LAB_08-Manage_Virtual_Machines.html>

### Virtual Machine and install a small web server

> [!IMPORTANT]
> Please follow the instructions in this lab - **Exercise 1**: <https://mslearn.cloudguides.com/en-us/guides/AZ-900%20Exam%20Guide%20-%20Azure%20Fundamentals%20Exercise%201>

### Advanced: Use PaaS App Service instead of VM

> [!IMPORTANT]
> Please follow the instructions in this lab - **Exercise 2**: <https://mslearn.cloudguides.com/en-us/guides/AZ-900%20Exam%20Guide%20-%20Azure%20Fundamentals%20Exercise%202>

## Learning resources

- About Virtual machines and Virtual Machine Scale Sets: <https://youtu.be/OykMc6wKMJY>

## Continue

**[home](../../README.md) | [next >](../chapter-2/README.md) | [solutions](../../solutions/chapter-1/README.md)**
