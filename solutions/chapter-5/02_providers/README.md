# 02 — Multiple providers with aliases

> **Level:** Beginner · **Time:** ~10 min
> **OPTIONAL** — requires a personal GitHub account + Personal Access Token.

This challenge shows how a single Terraform configuration can talk to
**two different providers at once** (`azurerm` and `github`), and how
**provider aliases** let you address them explicitly. We create:

- one Azure **resource group**
- one **GitHub repository** with the same name
- one `README.md` **file** inside that repository

> [!NOTE]
> Skip this folder if you don't have a personal GitHub account / PAT and
> jump to [03_variables](../03_variables/README.md). The provider-alias
> concept is also covered in the workshop slides.

## Prerequisites

- An Azure subscription, signed in via `az login`
- [Terraform](https://www.terraform.io/downloads.html) >= 1.5
- A [GitHub account](https://github.com) and a **Personal Access Token**
  with the `repo` scope:
  1. Open <https://github.com/settings/tokens>
  2. **Generate new token** → **Generate new token (classic)**
  3. Name it (e.g. `azure-hacks`), set an expiry, tick **`repo`**
  4. **Copy the value** — you will not see it again

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

The `github` provider reads its credentials from environment variables
— so the PAT never ends up in any `.tf` file:

```pwsh
$env:GITHUB_TOKEN = "ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
$env:GITHUB_OWNER = "your-github-username"
```

```bash
export GITHUB_TOKEN="ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export GITHUB_OWNER="your-github-username"
```

> [!IMPORTANT]
> Never commit your PAT to git. Setting it through environment
> variables (as above) is the safe way.

## 2. Deploy

```pwsh
terraform init
terraform plan
terraform apply -auto-approve
```

You will end up with a resource group named `rg-providers-<pet>` in
Azure and a private repo with the same name in your GitHub account.

## 3. Destroy

```pwsh
terraform destroy -auto-approve
```

## What this teaches you

- A single Terraform config can target **multiple platforms**.
- `provider "x" { alias = "..." }` lets you declare more than one
  configuration of the same provider and pick which one each resource
  uses via `provider = x.alias_name`.
- Provider credentials belong in **environment variables**, not in
  source files.

## Troubleshooting

- **`401 Bad credentials`** from GitHub — `GITHUB_TOKEN` is missing,
  expired, or lacks the `repo` scope.
- **`name already exists on this account`** — a previous run left a
  repo behind. Delete it in the GitHub UI or run `terraform destroy`.
- **`obtain subscription` / `building AzureRM Client`** — you forgot
  `az login` or `ARM_SUBSCRIPTION_ID`.

**[< back to Chapter 5 solutions](../README.md)**
