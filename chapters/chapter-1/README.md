# Chapter 1 - Technical Basics

## Goal

 This chapter is mostly instructor led and will introduce the following topics:

- Azure Basics (Subscription, Resource group, Tenant, Enrollment, Resource and Policies)
- Shared Responsibility Model (MSFT vs. Customer)
- Comparison: IaaS, PaaS, CaaS, SaaS
- Enterprise Scale (Landing Zone)
- Hub & Spoke Network Topology
- Recommended Tools (az-CLI, PowerShell, CloudShell, azd, Terraform, kubectl, Docker/Podman, VS Code)

The whole chapter is about setting the baseline to underastand the very basics of today's cloud computing and the Azure platform.

## Shared Responsibility Model

The shared responsibility model is a framework that defines the security responsibilities of cloud service providers and customers. It helps to establish clear boundaries and expectations for securing cloud environments. The shared responsibility model is based on the principle that cloud service providers are responsible for securing the underlying infrastructure and services, while customers are responsible for securing their data, applications, and configurations.

> [!CAUTION]
> **Important**: The instructor should explain the shared responsibility model in detail.
> 
> Use the following slides to show the differences: https://microsofteur-my.sharepoint.com/:p:/g/personal/joergjo_microsoft_com/Eb03Y_3KrE9GmnPuZS-JmE8BswCW-Y3Mvi7gmfYjvkehug?e=JoWLxj
> 
> The following article will help: https://learn.microsoft.com/en-us/training/modules/describe-cloud-compute/4-describe-shared-responsibility-model

![alt text](https://learn.microsoft.com/en-us/training/wwl-azure/describe-cloud-compute/media/shared-responsibility-b3829bfe.svg)


## Comparison: IaaS, PaaS, CaaS, SaaS

> [!CAUTION]
> **Important**: The instructor should explain the differences between IaaS, PaaS, CaaS, and SaaS. Follow the flow here: 
> ➡️ https://learn.microsoft.com/en-us/training/paths/microsoft-azure-fundamentals-describe-cloud-concepts/
> 
> Use the following slides to show the differences: https://microsofteur-my.sharepoint.com/:p:/g/personal/joergjo_microsoft_com/Eb03Y_3KrE9GmnPuZS-JmE8BswCW-Y3Mvi7gmfYjvkehug?e=JoWLxj
>

## Azure Basics

The Azure Enterprise Enrollment framework enables organizations to manage their Azure services, resources, and billing efficiently. Below is an overview of the hierarchical structure depicted in the image.

> [!CAUTION]
> **Important**: The instructor should explain the following concepts in detail using these slides: https://microsofteur-my.sharepoint.com/:p:/g/personal/joergjo_microsoft_com/ERefbkLz4kVNtfVmbK4oT3wBiWgvHTnZU4gDN-qxJ9Cm9Q?e=f9vJSv
> 

### Enrollment
**Enrollment** represents the agreement between an organization and Microsoft for the use of Azure services. It serves as the highest level of the hierarchy, allowing for centralized management and consolidated billing for the entire organization.

#### Department
**Department** is a logical grouping within an enrollment that represents different divisions or units within an organization. Departments help to segment the organization for better management of costs, resources, and administrative control. Each department can contain multiple accounts.

#### Account
**Account** is a management entity within a department that serves as a billing and access control boundary. It is used to organize and manage subscriptions, providing a way to allocate costs and manage resources by specific projects, teams, or business units.

#### Subscription

**Subscription** is a logical container within an account used to provision and manage Azure resources. Each subscription has its own set of resource quotas, billing cycle, and security boundaries. Subscriptions allow for the isolation of environments, such as development, testing, and production, within the organization.

![alt text](https://miro.medium.com/v2/resize:fit:4800/format:webp/1*DIu5y3UYX7rEH1z1igvQpA.png)

![alt text](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/media/ea.png)

![alt text](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/enterprise-scale/media/ea-azure-relationship.png)

> [!TIP]
>
> It might be useful to explain why subscription vending always needs an existing subscription. 
> Show this small Terraform code:

```hcl
provider "azurerm" {
  features {}
  subscription_id = "<existing_subscription_id>"
}

resource "azurerm_subscription" "example" {
  display_name    = "New Subscription"
  billing_scope_id = "<billing_scope_id>"
  parent_management_group_id = "<management_group_id>"
}
```

### Policies

**Policies** are a set of rules and guidelines that help organizations enforce compliance, security, and governance standards within their Azure environment. Policies can be used to define restrictions, permissions, and best practices for resource management, access control, and configuration settings.

> [!CAUTION]
> **Important**: The instructor should explain the concept of policies in detail. Going into the Azure portal and showing how to create a policy might be helpful. Even further it is useful to show how to assign a policy to a subscription or resource group. For more details and some guidance it is recommended to use the following slides: https://microsofteur-my.sharepoint.com/:p:/g/personal/joergjo_microsoft_com/ESgw92N56IBFuENs44JxDa8BRW3Gi1A4U4Khcx7oND_biA?e=gWKKdj

## Enterprise Scale (Landing Zone)

The Enterprise-Scale Landing Zone is a blueprint that provides prescriptive guidance on how to set up an environment in Azure that is well-architected, secure, and scalable. It is designed to help organizations establish a foundation for cloud adoption that aligns with best practices and industry standards.

> [!CAUTION]
> **Important**: The instructor should explain the Enterprise-Scale Landing Zone Pattern in detail.
> It might be easier to open this link https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/ and use this as an interactive slide.
>
> In addition to this it might be useful to show the following slides: https://microsofteur-my.sharepoint.com/:p:/g/personal/joergjo_microsoft_com/EYadYmN3vLFNnhhIyCp2aIMB26ckxaR7C7PEFWGGLceZNA?e=St7maM

### Hub and spoke network topology

> [!CAUTION]
> **Important**: The instructor should explain the Hub and Spoke Network Topology in detail.
>
> It is recommend to open the following article and use this as a guide for the discussion: https://learn.microsoft.com/en-us/azure/architecture/networking/architecture/hub-spoke?tabs=cli

![](https://learn.microsoft.com/en-us/azure/architecture/networking/architecture/_images/hub-spoke.png#lightbox)

## Recommended Tools

> [!CAUTION]
> **Important**: The instructor should explain the recommended tools in detail. And also show how to install these.

- **az-CLI**: The Azure Command-Line Interface (CLI) is a set of commands used to manage Azure resources from the command line or scripts. It provides a way to automate tasks, manage resources, and interact with Azure services using a text-based interface.
- **PowerShell**: PowerShell is a task automation and configuration management framework that provides a command-line shell and scripting language for managing Windows and Azure resources. It allows for the automation of administrative tasks, configuration settings, and resource management.
- **CloudShell**: Azure Cloud Shell is a browser-based shell that provides access to Azure resources and tools directly from the Azure portal. It allows for the execution of commands, scripts, and tools in a cloud-hosted environment without the need to install or configure anything locally.
- **azd**: Azure DevOps (azd) is a set of services that provide development, build, test, and deployment capabilities for software development projects. It includes tools for version control, continuous integration, continuous delivery, and collaboration to streamline the software development lifecycle.
- **Terraform**: Terraform is an open-source infrastructure as code (IaC) tool that allows for the provisioning and management of cloud resources using declarative configuration files. It enables the automation of infrastructure deployment, configuration, and updates across multiple cloud providers.
- **kubectl**: Kubernetes Command-Line Tool (kubectl) is used to interact with Kubernetes clusters to deploy, manage, and monitor containerized applications. It provides a way to access and control Kubernetes resources, pods, services, and deployments from the command line.
- **Docker/Podman**: Docker and Podman are containerization platforms that allow for the creation, deployment, and management of containerized applications. They provide a way to package applications and their dependencies into lightweight, portable containers that can run on any platform.
- **VS Code**: Visual Studio Code (VS Code) is a lightweight, open-source code editor that provides a rich set of features for code editing, debugging, and version control. It supports a wide range of programming languages, extensions, and integrations to enhance productivity and collaboration.

### AZ-CLI

#### Installation

https://learn.microsoft.com/en-us/cli/azure/install-azure-cli

#### Examples

> [!CAUTION]
> **Important**: The instructor should show how to use the Azure CLI with some examples.
> 

```bash
# Login to Azure
az login
# login with another tenant
az login --tenant <tenant-id>
# Show all subscriptions
az account list
# Set default subscription
az account set --subscription <subscription-id>
# Show all resource groups
az group list
# Show all resources in a resource group
az resource list -g <resource-group-name>
# Show all resource groups and format with table
az group list --output table
# use the query feature to only get names
az group list --query '[].name'
# Show all resources in a resource group and format with table
az resource list -g <resource-group-name> --output table    
```
#### Cheat Sheet

For a complete cheat sheet see [here](./assets/azcli-cheatsheet.md)

### PowerShell

#### Installation

> [!CAUTION]
> **Important**: The instructor should show how to use the PowerShell with some examples.
> 

https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell

For the Azure PowerShell module see [here](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps)
Azure Module is preinstalled in Cloud Shell, but not in PowerShell on your local machine or dev box. 

You can install it with the following command:

```powershell
# Install module Az
Install-Module Az
```

#### Examples

```powershell
# Install module Az
Install-Module Az
# Login to Azure
Connect-AzAccount
# Show all subscriptions
Get-AzSubscription
# Set default subscription
Set-AzContext -Subscription <subscription-id>
# Show all resource groups
Get-AzResourceGroup
# Show all resources in a resource group
Get-AzResource -ResourceGroupName <resource-group-name>
# Show all resource groups and format with table
Get-AzResourceGroup | Format-Table
# Show all resource groups with their resources
Get-AzResourceGroup | ForEach-Object { Write-Host $_.ResourceGroupName; Get-AzResource -ResourceGroupName $_.ResourceGroupName }
# Output in joined table to get a nice overview with rerource group and resources and color them accordingly. Create a markdown table
Get-AzResourceGroup | ForEach-Object { Write-Host $_.ResourceGroupName; Get-AzResource -ResourceGroupName $_.ResourceGroupName | Format-Table }
```

#### Cheat Sheet

For a complete cheat sheet see [here](./assets/pwshl-cheatsheet.md)

## CloudShell

> [!CAUTION]
> **Important**: The instructor should show how to use the Cloud shell with some examples.
> 

Azure Cloud Shell is an interactive, browser-accessible shell for managing Azure resources. It provides the flexibility of choosing the shell experience that best suits the way you work. Linux users can opt for a Bash experience, while Windows users can opt for PowerShell.

Go to: https://portal.azure.com/#cloudshell/

### Azure Developer CLI

> [!CAUTION]
> **Important**: The instructor should show how to use the Azure Developer CLI. Deploy the example and navigate through the template gallery and template. 
> 

The Azure Developer CLI (azd) is an open-source tool that accelerates the time it takes for you to get started on Azure. azd provides a set of developer-friendly commands that map to key stages in your workflow (code, build, deploy, monitor). The CLI allows you to work consistently in a repeatable way across the terminal, your editor/integrated development environment, GitHub Actions pipeline, and more.

Overview: https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/

Installation: https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/install-azd?tabs=winget-windows%2Cbrew-mac%2Cscript-linux&pivots=os-mac

Templates: https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/azure-developer-cli-templates

#### Template Gallery

https://azure.github.io/awesome-azd/

#### Example deployment

Use the following example to deploy a web app to Azure: https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/get-started?tabs=localinstall&pivots=programming-language-java

### Terraform

> [!CAUTION]
> **Important**: The instructor should show how to install Terraform and verify that it is working.
> You can use the following repository to do so: https://github.com/jeffreygroneberg/basic_tf/tree/main/basic

Terraform is an open-source infrastructure as code (IaC) tool that allows for the provisioning and management of cloud resources using declarative configuration files. It enables the automation of infrastructure deployment, configuration, and updates across multiple cloud providers.

#### Installation

Installation: https://learn.hashicorp.com/tutorials/terraform/install-cli

#### Examples

```bash
# Get terraform version
terraform version

# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply the deployment
terraform apply

# Destroy the deployment
terraform destroy
```

#### Deploy a resource group

Use the latest version of the Azure provider and create a resource group: https://registry.terraform.io/providers/hashicorp/azurerm/latest
Check if the current subscription is set in the Azure CLI: 
    
```bash
az account show --query "name" -o tsv
```

```hcl
# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
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

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}
``` 

For a more complex, but still simple example you should deploy this repository: https://github.com/jeffreygroneberg/basic_tf?tab=readme-ov-file

#### Cheat Sheet

For a complete cheat sheet see [here](./assets/tf-cheatsheet.md)

## kubectl

> [!CAUTION]
> **Important**: The instructor should show how to install kubectl and verify that it is working.

Kubectl is a command-line tool that allows you to interact with Kubernetes clusters to deploy, manage, and monitor containerized applications. It provides a way to access and control Kubernetes resources, pods, services, and deployments from the command line. 

#### Installation

Installation: https://kubernetes.io/docs/tasks/tools/install-kubectl/

#### Examples

Use the repository https://github.com/jeffreygroneberg/basic_tf/tree/main/aks in conjunction with the installation guide: https://learn.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-terraform?pivots=development-environment-azure-cli#initialize-terraform

Afterwards you can show these small examples:

```bash
# Get kubectl version
kubectl version

# Get cluster information
kubectl cluster-info

# Get nodes in the cluster
kubectl get nodes

# Get namespaces in the cluster
kubectl get namespaces

# Get pods in a namespace
kubectl get pods -n <namespace>

# Get services in a namespace
kubectl get services -n <namespace>
```

## Additional Learning Resources

### Azure Basics

- John Savill AZ-900 course: https://www.youtube.com/playlist?list=PLlVtbbG169nED0_vMEniWBQjSoxTsBYS3

### Azure Landing Zones

- John Savil: https://youtu.be/mluS8ovuBKg
- Choosing the best Landing Zone: https://youtu.be/vUVY6j-_n-w

### Azure Developer CLI

- Training: https://learn.microsoft.com/en-us/training/paths/azure-developer-cli/

## Continue

**[< back](../../README.md) | [next >](../chapter-2/README.md) | [solutions](../../solutions/chapter-1/README.md)**
