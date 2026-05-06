# Chapter 3 - Lab: Container Registry with Terraform

> This lab is adapted from the Day 3 advanced lab (Chapter 5, ch-04). It provides a Terraform-based challenge for creating an ACR after you've learned the concepts in the earlier chapters.

---

## Prerequisites

Before starting this lab, make sure you have:
- Completed **Chapter 1** (understand ACR concepts)
- Azure CLI logged in and subscription set (`az account show` to verify)
- Terraform installed (`terraform version` to verify)
- A working directory for your Terraform files (e.g., `mkdir C:\lab-acr; cd C:\lab-acr`)

> **Reminder:** You need a Terraform project set up with the AzureRM provider. If you're building on the previous day's work, you can add the ACR to your existing `main.tf`. Otherwise, create new `providers.tf`, `variables.tf`, and `main.tf` files.

---

# 4 - Container Registry
You will soon create a Kubernetes cluster, but a prerequisite for any container platform is a store for your container images - a registry. 

## Objectives
- Create an Azure Container Registry (ACR).
- Place the ACR in your existing resource group in Sweden Central.
- Randomize the registry's name the same way you have randomized your resource group's name.
- Use the `Basic` SKU.
- Disable admin access.

> The purpose of "disable admin access" is to disable traditional username/password based authentication. You will use Entra ID based access instead.

> **Important:** ACR names must be **globally unique** and can only contain **lowercase letters and numbers** (no dashes, underscores, or special characters). If you use `random_string`, make sure to set `special = false` and `upper = false`. If you use `random_integer` combined with a prefix, strip out any dashes with `replace()`.

## Success Criteria
- The ACR is up and running.
- You can upload the test application's source code to the ACR and have it build a container image.

### Verification
On your PowerShell terminal run the following command. Use Azure Cloud Shell if you are not able to connect to ACR via PowerShell.

> **Tip:** The `--expose-token` flag is needed because `az acr login` without it requires Docker Desktop to be running. The `az acr build` command works without Docker — it builds in the cloud.

```powershell
# Replace youracr with your registry's name 
az acr login -n "youracr" --expose-token
az acr build -r "youracr" -t go-probe:latest --platform linux/amd64 https://github.com/joergjo/go-probe.git
```

This step will pull down the source code of our test application into your registry and build a container image. The application will be used later throughout this lab for additional verification steps.

> **Note:** The build takes ~1-2 minutes. You'll see build logs streaming in real time. It's complete when you see `Run ID: xxx was successful`.

## Terraform Hint

The main resource you need:

```hcl
resource "azurerm_container_registry" "acr" {
  name                = "yourUniqueAcrName"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Basic"
  admin_enabled       = false
}
```

You can use `random_string` to generate a unique suffix:

```hcl
resource "random_string" "acr_suffix" {
  length  = 8
  special = false
  upper   = false
}
```

Or if you already have a `random_integer` resource for your resource group name, you can reuse it:

```hcl
# Example: If your prefix is "lab" and random_integer gives "3945",
# the ACR name would be "lab3945images"
resource "azurerm_container_registry" "acr" {
  name                = "${replace(local.name_prefix, "-", "")}images"
  ...
}
```

## Common Mistakes

| Mistake | Symptom | Fix |
|---------|---------|-----|
| ACR name contains dashes | `InvalidContainerRegistryName` error | Use `replace()` to strip dashes: `replace("lab-3945", "-", "")` |
| ACR name not unique | `ContainerRegistryNameNotAvailable` | Add more randomness or a longer suffix |
| Forgot `random` provider | `Could not retrieve the list of available versions` | Add `hashicorp/random` to your `required_providers` block |

## Learning resources
- [azurerm_container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry)
- [Quickstart: Use Terraform to create a Linux VM](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-terraform?tabs=azure-cli)
- [Quickstart: Build and run a container image using Azure Container Registry Tasks](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-quickstart-task-cli)

## Sample solution
See [here](../../solutions/chapter-7/ch-04/).

---

## Stuck? Deploy the solution and continue

If you can't get your Terraform code to work, you can deploy the provided solution and move on to the next chapter:

```powershell
# Copy the solution to a working directory
# Replace <repo> with the path where you cloned the Cloud-Academy repo
# e.g., C:\Cloud-Academy or wherever you ran `git clone`
Copy-Item -Recurse -Force "<repo>\AzureBaseTraining\solutions\chapter-7\ch-04\*" C:\lab-solution\
cd C:\lab-solution
```

> **Important:** Before deploying, open `variables.tf` and set the `ssh_key` variable to your SSH public key (the default is empty and **must** be filled):
> ```powershell
> # If you don't have an SSH key yet, generate one:
> ssh-keygen -t rsa -b 4096 -f "$env:USERPROFILE\.ssh\id_rsa" -N '""'
> # Then copy the public key content and paste it into variables.tf:
> Get-Content "$env:USERPROFILE\.ssh\id_rsa.pub"
> ```

```powershell
terraform init
terraform apply
```

Once deployed, continue with [Chapter 4](../chapter-4/README.md).

---

**[< back](../chapter-2/README.md) | [next: AKS Lab (Terraform) >](../chapter-4/README.md)**
