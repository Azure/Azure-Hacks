# State

## Overview

This repository showcases how to configure a remote backend for Terraform.
It is necessary to store the state file in a remote location when working in a team or when using a CI/CD pipeline.

For this case we need a storage account in Azure, and we will use the Azure Blob Storage as the backend for Terraform.

## Prerequisites

- An Azure account
- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed on your local machine
- Permission to create role assignments in your subscription (`Owner` or
  `User Access Administrator`). The L0 module grants you the
  `Storage Blob Data Contributor` role on the storage account so that
  Terraform can create the container with Entra ID authentication.

> [!NOTE]
> Many Microsoft-managed Azure tenants (including the CloudAcademy / Hack
> tenants) enforce a Defender for Storage policy that disables **shared-key
> access** on every newly-created storage account
> (`allowSharedKeyAccess = false`). The Terraform configuration in this
> chapter therefore uses **Entra ID (Azure AD) authentication** for storage
> data-plane operations (`storage_use_azuread = true` on the provider,
> `use_azuread_auth = true` on the backend).

## Configuration Details

### L0 - Storage Account

This level creates the storage account that will be used as the backend for Terraform. We are using random strings for the name of the resource group and the storage account to avoid conflicts.
All the created names will be part of the output.

It also assigns the `Storage Blob Data Contributor` role on the storage
account to the user running `terraform apply`, which is required for
container creation when shared-key access is disabled.

### L1 - Backend Configuration

Here we use a configured backend to create a random resource group and store the state file in the storage account created in the previous level.

## Deployment Steps

> [!CAUTION]
> Please follow the instructions and ALWAYS destroy your environment so that you can move on with a clean slate.

### L0 - Storage Account

1. Run `az login` to authenticate with your Azure account.
2. Export the target subscription id so Terraform's azurerm v3 provider
   picks it up:
   - PowerShell: `$env:ARM_SUBSCRIPTION_ID = (az account show --query id -o tsv)`
   - bash:       `export ARM_SUBSCRIPTION_ID=$(az account show --query id -o tsv)`
3. Run `terraform init` to initialize the Terraform configuration.
4. Run `terraform plan` to view the resources that will be created.
5. Run `terraform apply` to create the resources.
6. Note down the outputs for the resource group, storage account and container.

### L1 - Backend Configuration

1. Run `az login` to authenticate with your Azure account (same user that ran
   L0, otherwise grant the new user the `Storage Blob Data Contributor` role
   on the storage account first).
2. Fill in the values you noted down in the previous level for your backend configuration in the `providers.tf` file:
   ```hcl
   terraform {
     backend "azurerm" {
       resource_group_name  = "YOUR_RESOURCE_GROUP_NAME"
       storage_account_name = "YOUR_STORAGE_ACCOUNT_NAME"
       container_name       = "YOUR_CONTAINER_NAME"
       key                  = "terraform.tfstate"
       use_azuread_auth     = true
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

1. Run `terraform destroy` in **L1 first** (so the state is removed from the
   backend before the backend itself is destroyed), then in L0.

## Troubleshooting

- **`403 Key based authentication is not permitted on this storage account.`**
  Your tenant disables shared-key access on storage accounts. Make sure both
  the provider (`storage_use_azuread = true`) and the backend
  (`use_azuread_auth = true`) are configured to use Entra ID, as in the
  files in this folder.
- **`AuthorizationPermissionMismatch` when creating the container or running
  `terraform init` for L1.** The signed-in identity is missing the
  `Storage Blob Data Contributor` role on the storage account. L0 creates
  this assignment automatically; if you switched user between L0 and L1,
  re-run L0 or add the role manually.
- **`AuthorizationPermissionMismatch` on the very first `terraform init` of
  L1 right after L0 finished.** Azure AD role assignments take **up to a
  couple of minutes** to propagate. Wait 30–60 seconds and re-run
  `terraform init` — it will succeed.


