# Terraform State

## Overview

This repository showcases how to configure a remote backend for Terraform.
It is necessary to store the state file in a remote location when working in a team or when using a CI/CD pipeline.

For this case we need a storage account in Azure, and we will use the Azure Blob Storage as the backend for Terraform.

## Prerequisites

- An Azure account
- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed on your local machine

## Configuration Details

### L0 - Storage Account

This level creates the storage account that will be used as the backend for Terraform. We are using random strings for the name of the resource group and the storage account to avoid conflicts.
All the created names will be part of the output.

### L1 - Backend Configuration

Here we use a configured backend to create a random resource group and store the state file in the storage account created in the previous level.

## Deployment Steps

> [!IMPORTANT]
> Please follow the instructions and ALWAYS destroy your environment so that you can move on with a clean slate.

### L0 - Storage Account

1. Run `az login` to authenticate with your Azure account.
2. Run `terraform init` to initialize the Terraform configuration.
3. Run `terraform plan` to view the resources that will be created.
4. Run `terraform apply` to create the resources.
5. Note done the outputs for the resource group, storage account and container.

### L1 - Backend Configuration

1. Run `az login` to authenticate with your Azure account.
2. Fill in the values you noted down in the previous level for your backend configuration in the `provider.tf` file:

    ```hcl
      terraform {
        backend "azurerm" {
          resource_group_name   = "YOUR_RESOURCE_GROUP_NAME"
          storage_account_name  = "YOUR_STORAGE_ACCOUNT_NAME"
          container_name        = "YOUR_CONTAINER_NAME"
          key                   = "terraform.tfstate"
        }
      }
      ```

3. Run `terraform init` to initialize the Terraform configuration.
4. Run `terraform plan` to view the resources that will be created.
5. Run `terraform apply` to create the resources.

### Check the state in the Azure portal

1. Go to the Azure portal and check the storage account and the container.
2. You should see the `terraform.tfstate` file in the container.
3. You can also check the state file by downloading it and checking the content.
4. Check if the resource group has been created.

### Destroy both levels

1. Run `terraform destroy` in both levels folders to delete the resources.
