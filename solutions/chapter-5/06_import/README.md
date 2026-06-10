# Import

## Overview

This module showcases the **Terraform import** workflow: bringing
existing Azure resources that were created outside of Terraform under
Terraform management.

We use the modern `import { ... }` block (Terraform >= 1.5) together with
`terraform plan -generate-config-out=...` so you do not need to hand-write
the resource block first.

## Prerequisites

- An Azure account
- [Terraform](https://www.terraform.io/downloads.html) >= 1.5 on your local
  machine
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
  installed and signed in (`az login`)

## Configuration Details

`main.tf` creates a single resource group with a random suffix. After it
is applied you will create an **Azure Storage Account** in that resource
group **outside of Terraform** (using the Azure CLI), then use
`terraform import` to bring it under Terraform management.

## Deployment Steps

> [!CAUTION]
> Please follow the instructions and ALWAYS destroy your environment so
> that you can move on with a clean slate.

### 1. Create the baseline resource group with Terraform

```pwsh
# PowerShell
$env:ARM_SUBSCRIPTION_ID = (az account show --query id -o tsv)
terraform init
terraform apply -auto-approve
```

```bash
# bash / zsh
export ARM_SUBSCRIPTION_ID=$(az account show --query id -o tsv)
terraform init
terraform apply -auto-approve
```

Note the value of the `resource_group_name` output — we will use it in
the next step.

### 2. Create a storage account outside of Terraform

Pick a globally-unique storage account name (3–24 lower-case letters and
digits) and create it with the Azure CLI:

```pwsh
$rg = terraform output -raw resource_group_name
$sa = "import" + -join ((48..57) + (97..122) | Get-Random -Count 12 | ForEach-Object { [char]$_ })
az storage account create `
  --name $sa `
  --resource-group $rg `
  --location westeurope `
  --sku Standard_LRS `
  --kind StorageV2
```

```bash
RG=$(terraform output -raw resource_group_name)
SA="import$(LC_ALL=C tr -dc 'a-z0-9' </dev/urandom | head -c 12)"
az storage account create \
  --name "$SA" \
  --resource-group "$RG" \
  --location westeurope \
  --sku Standard_LRS \
  --kind StorageV2
```

Capture the storage account's resource ID — `terraform import` needs it:

```pwsh
$id = az storage account show -n $sa -g $rg --query id -o tsv
```

```bash
ID=$(az storage account show -n "$SA" -g "$RG" --query id -o tsv)
```

### 3. Declare the import in `imports.tf`

Create a file `imports.tf` next to `main.tf` with:

```hcl
import {
  to = azurerm_storage_account.imported
  id = "PASTE_THE_RESOURCE_ID_HERE"
}
```

### 4. Let Terraform generate the resource block for you

```pwsh
# PowerShell users: the flag MUST be quoted, otherwise PowerShell
# splits it and Terraform complains "Too many command line arguments".
terraform plan "-generate-config-out=generated.tf"
```

```bash
terraform plan -generate-config-out=generated.tf
```

Terraform writes a fully-populated `azurerm_storage_account.imported`
block to `generated.tf`. Open it and clean it up — `apply` will fail
otherwise because the generator emits a few invalid defaults:

- **Delete the whole `blob_properties { ... }`, `queue_properties { ... }`
  and `share_properties { ... }` blocks** if you don't need them. The
  generator writes `retention_policy_days = 0` inside them, which the
  provider rejects (`expected ... to be in the range (1 - 365), got 0`).
- (Optional) bump `min_tls_version` from `TLS1_0` to `TLS1_2`.

The cleaned-up block can be as small as:

```hcl
resource "azurerm_storage_account" "imported" {
  name                     = "<your storage account name>"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  min_tls_version          = "TLS1_2"
}
```

### 5. Apply the import

```pwsh
terraform apply
```

A subsequent `terraform plan` should report **No changes** — the
storage account is now managed by Terraform.

### 6. (Alternative – the classic CLI workflow)

If you are on Terraform < 1.5, use the classic CLI command instead of an
`import` block:

1. Add an empty resource block to your configuration:
   ```hcl
   resource "azurerm_storage_account" "imported" {
     # filled in after import
   }
   ```
2. Run the import:
   ```pwsh
   terraform import azurerm_storage_account.imported $id
   ```
3. Run `terraform state show azurerm_storage_account.imported` and copy
   the relevant attributes into the resource block until
   `terraform plan` reports no changes.

### 7. Clean up

```pwsh
terraform destroy -auto-approve
Remove-Item imports.tf, generated.tf -ErrorAction SilentlyContinue
```

```bash
terraform destroy -auto-approve
rm -f imports.tf generated.tf
```

## Reference

- [`import` block – Terraform docs](https://developer.hashicorp.com/terraform/language/import)
- [`azurerm_storage_account` – import section](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#import)