# JSON-driven resources

> [!IMPORTANT]
> **This challenge is OPTIONAL** because it requires a personal GitHub
> account with a Personal Access Token. If you don't have one, skip
> this folder and continue with
> [../../05_state](../../05_state/README.md). The `jsondecode` +
> `for_each` pattern is straightforward to read through even without
> running it.

## Overview

This Terraform module shows how to read a **JSON configuration file**
and use it as the source of truth for `for_each`-driven resources.

`conf/config.json` is a small list of objects. For every object in that
list we create:

- an Azure **resource group** in the specified location
- a **GitHub repository** with the specified name + description
- a `README.md` **file** inside that repository with the specified content

Add or remove an entry in `conf/config.json` and re-run `terraform
apply` to scale the deployment up or down — no `.tf` change required.

## Prerequisites

- An Azure account
- [Terraform](https://www.terraform.io/downloads.html) >= 1.5 on your local machine
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed on your local machine
- A [GitHub account](https://github.com)
- A **GitHub Personal Access Token (PAT)** with `repo` scope. To create
  one:
  1. Open <https://github.com/settings/tokens>.
  2. Click **Generate new token** → **Generate new token (classic)**.
  3. Give it a name (e.g. `azure-hacks`) and an expiry.
  4. Tick the **`repo`** scope (everything under `repo`).
  5. Click **Generate token** and **copy the value** — you will not
     see it again.

## 1. Authenticate

### Azure

```pwsh
az login
$env:ARM_SUBSCRIPTION_ID = (az account show --query id -o tsv)
```

```bash
az login
export ARM_SUBSCRIPTION_ID=$(az account show --query id -o tsv)
```

### GitHub

The `github` provider reads credentials from environment variables, so
you do **not** put your PAT into any `.tf` file:

```pwsh
# PowerShell
$env:GITHUB_TOKEN = "ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
$env:GITHUB_OWNER = "your-github-username"
```

```bash
# bash / zsh
export GITHUB_TOKEN="ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export GITHUB_OWNER="your-github-username"
```

> [!IMPORTANT]
> Never commit your PAT to git. Setting it through env vars (as above)
> is the safe way.

## 2. Inspect the JSON

Open [`conf/config.json`](./conf/config.json). Each entry has five
fields — feel free to change the names so they don't collide with
something already in your account:

```json
{
  "rg_name": "exampleResourceGroup1",
  "location": "West Europe",
  "repo_name": "exampleRepo1",
  "repo_desc": "Repository for exampleResourceGroup1",
  "repo_content": "Content for exampleRepo1"
}
```

## 3. Deploy

> [!CAUTION]
> Always destroy your environment at the end so you start the next
> challenge with a clean slate.

```pwsh
terraform init
terraform plan
terraform apply -auto-approve
```

## 4. Destroy

```pwsh
terraform destroy -auto-approve
```

## Troubleshooting

- **`Error: GET https://api.github.com/...: 401 Bad credentials`** —
  your `GITHUB_TOKEN` is missing, expired, or lacks the `repo` scope.
- **`Error: name already exists on this account`** — a GitHub repo
  with that name already exists. Either delete it or edit
  `conf/config.json` to use a unique name.
- **`Error: building AzureRM Client: obtain subscription`** — you
  forgot `ARM_SUBSCRIPTION_ID` or `az login`.
