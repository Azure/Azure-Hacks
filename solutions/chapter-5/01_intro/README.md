# 01 — Intro: your first Terraform deployment on Azure

> **Level:** Beginner · **Time:** ~5 min

A "hello world" for Terraform on Azure. You will deploy **one resource
group** and immediately destroy it again. The goal is just to confirm
that Terraform, the Azure CLI and your subscription are wired up
correctly before moving on to the next challenges.

## Prerequisites

- An Azure subscription you can deploy into
- [Terraform](https://www.terraform.io/downloads.html) installed
  (`terraform version` works in your shell)
- [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli)
  installed (`az version` works in your shell)

## Deploy

```pwsh
az login
terraform init
terraform plan
terraform apply -auto-approve
```

After apply, you should see an output similar to:

```
resource_group_name = "rg-intro-clever-puma"
```

You can verify it exists with:

```pwsh
az group show -n (terraform output -raw resource_group_name) -o table
```

## Destroy

> [!CAUTION]
> Always destroy after each challenge so you start the next one with a
> clean slate (and no surprise bills).

```pwsh
terraform destroy -auto-approve
```

## What this teaches you

- The `terraform init / plan / apply / destroy` workflow.
- That `azurerm` reuses your `az login` credentials — no extra config
  needed.
- That `random_pet` is the easiest way to give resources unique names
  so multiple participants don't collide.

**[< back to Chapter 5 solutions](../README.md)**
