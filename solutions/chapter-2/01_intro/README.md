# Azure Infrastructure Deployment with Terraform

## Overview

This Terraform configuration sets up basic Azure infrastructure with a a resource group.

## Prerequisites

- An Azure account
- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed on your local machine

## Configuration Details

- **Resource Group**: A resource group named `example-resources` located in `West Europe`.

## Deployment Steps

1. Clone this repository to your local machine (if not already done). **Careful: forking the repository might be the better option**
2. Open a terminal window and navigate to the root of the cloned repository.
3. Run `az login` to authenticate with your Azure account.
4. Run `terraform init` to initialize the Terraform configuration.
5. Run `terraform plan` to view the resources that will be created.
6. Run `terraform apply` to create the resources.
7. Run `terraform destroy` to delete the resources when you're done.
