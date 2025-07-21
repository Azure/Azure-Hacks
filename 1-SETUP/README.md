# Prerequisites & Setup

**Complete this setup BEFORE the Azure Academy (21-24 July 2025)**

This guide will help you install and configure all the necessary tools required for the 4-day Azure hackathon experience. Please complete all setup steps before Day 1 to ensure you're ready to participate fully in the hands-on activities.

## Required Tools Overview

The following tools are essential for participating in the Azure hackathons:
- **Azure Developer CLI (azd)** - For rapid Azure application deployment
- **Azure CLI (az)** - For Azure resource management
- **Terraform** - For Infrastructure as Code
- **Visual Studio Code** - Primary development environment
- **PowerShell** - For Azure automation tasks

Open Visual Studio Code (VS Code) or a text editor. 
- Start with an empty directory.
- Open the Terminal.



### Azure Developer CLI

> **Important**: The instructor should show how to install Azure Developer CLI and verify that it is working.

- **Azure Developer CLI**: The [Azure Developer CLI (azd)](https://learn.microsoft.com/en-gb/azure/developer/azure-developer-cli/overview) is an open-source tool that accelerates your path from a local development environment to Azure. azd provides best practice, developer-friendly commands that map to key stages in your workflow, whether you're working in the terminal, your editor or integrated development environment (IDE), or CI/CD (continuous integration/continuous deployment).

Browse blueprint templates from [Azure Developer CLI Template Library](https://learn.microsoft.com/en-gb/azure/developer/azure-developer-cli/azd-templates?tabs=csharp)

#### Installation

Installation: [Install the Azure Developer CLI](https://learn.microsoft.com/en-gb/azure/developer/azure-developer-cli/install-azd?tabs=winget-windows%2Cbrew-mac%2Cscript-linux&pivots=os-windows)

    winget install microsoft.azd

Verify installation completed successfully by running the azd version command in a terminal:

    azd version

Optional - [Azure Developer CLI Visual Studio Code extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.azure-dev)

#### Examples

📘 How-To Guide: [Get started using Azure Developer CLI | Microsoft Learn](https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/get-started?tabs=localinstall&pivots=programming-language-nodejs)

## Recommended Tools

> [!CAUTION]
> **Important**: The instructor should explain the recommended tools in detail and also show how to install these.

- **az-CLI**: The Azure Command-Line Interface (CLI) is a set of commands used to manage Azure resources from the command line or scripts. It provides a way to automate tasks, manage resources, and interact with Azure services using a text-based interface.
- **VS Code**: Visual Studio Code (VS Code) is a lightweight, open-source code editor that provides a rich set of features for code editing, debugging, and version control. It supports a wide range of programming languages, extensions, and integrations to enhance productivity and collaboration.
- **PowerShell**: PowerShell is a task automation and configuration management framework that provides a command-line shell and scripting language for managing Windows and Azure resources. It allows for the automation of administrative tasks, configuration settings, and resource management.

> [!CAUTION]
> **Important**: The instructor should clearly mention that CloudShell often can not be used with BMW Tenants.
> 

- **Terraform**: Terraform is an open-source infrastructure as code (IaC) tool that allows for the provisioning and management of cloud resources using declarative configuration files. It enables the automation of infrastructure deployment, configuration, and updates across multiple cloud providers.

### Terraform

> [!CAUTION]
> **Important**: The instructor should show how to install Terraform and verify that it is working.

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

#### Cheat Sheet

For a complete Azure CLI cheat sheet see [here](https://learn.microsoft.com/en-us/cli/azure/cheat-sheet-onboarding)
An a terraform cheat sheet see [here](https://github.com/devops-cheat-sheets/terraform-cheat-sheet)

### Azure CLI Setup & Authentication

> [!CAUTION]
> **Important**: Complete Azure CLI setup and authentication before Day 1.

#### Installation
Install Azure CLI: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli

#### Authentication
```bash
# Login to Azure
az login

# Set your subscription (if you have multiple)
az account set --subscription "your-subscription-name-or-id"

# Verify your current subscription
az account show --query "name" -o tsv

# List all available subscriptions
az account list --output table
```

#### Enterprise Tenant Considerations
> [!CAUTION]
> **Important**: CloudShell often cannot be used with enterprise tenants. Use local Azure CLI installation instead.

## Success Criteria - Ready for Azure Academy

✅ You have successfully installed **Azure Developer CLI**  
✅ You have successfully installed **Terraform**  
✅ You have successfully installed **Azure CLI**  
✅ Visual Studio Code is installed and ready  
✅ PowerShell is configured and working  
✅ You can authenticate to Azure successfully  

**Once you've completed all setup steps, you're ready for the Azure Academy!**

### Additional Learning Resources

#### Azure Landing Zones
- John Savil: https://youtu.be/mluS8ovuBKg
- Choosing the best Landing Zone: https://youtu.be/vUVY6j-_n-w

#### Azure Developer CLI
- Training: https://learn.microsoft.com/en-us/training/paths/azure-developer-cli/

## Azure Academy Schedule

**Day 1 (21 July)**: [Security Hackathon](../5-SECURITY/README.md)  
**Day 2 (22 July)**: [Architecture Hackathon](../2-ARCHITECTURE/README.md)  
**Day 3 (23 July)**: [Development Hackathon](../4-DEVELOPING/README.md)  
**Day 4 (24 July)**: [Reliability Hackathon](../3-RELIABILITY/README.md)  

## Continue

**[< back](../../README.md) | [Start Day 1: Security >](../5-SECURITY/README.md)**