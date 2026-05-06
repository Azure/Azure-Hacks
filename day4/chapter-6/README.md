# Chapter 6 - Bonus Lab: Azure OpenAI with Terraform

> Deploy an Azure OpenAI service and interact with GPT-4o-mini. This lab teaches you how to provision AI services with Terraform and authenticate using Entra ID.

---

## Prerequisites

Before starting this lab, make sure you have:
- Completed **Chapter 3** (resource group exists in your Terraform project)
- Your Terraform project from the previous chapters (you’ll add OpenAI resources to it)
- Azure CLI logged in (`az account show` to verify)

> **⏱️ Time estimate:** The OpenAI account and model deployment takes **~1–2 minutes** via Terraform. The RBAC role propagation takes an additional **2–5 minutes**.

---

# 7 - Azure OpenAI

The final resource you will deploy is an Azure OpenAI service. This allows you to interact with large language models (LLMs) like GPT-4o through an API.

> **Important model update:** The original lab used `gpt-35-turbo-16k` which has been **deprecated since April 2025**. You will deploy `gpt-4o-mini` instead — a more capable and cost-effective model.

## 7a - Azure OpenAI Account

### Objectives
- Create a Cognitive Account of type `OpenAI`.
- Place the account in your existing resource group in Sweden Central.
- Select `S0` as SKU.
- Randomize the account name the same way you have randomized your resource group's name.
- Set a **custom subdomain name** (required for the API endpoint to work).

> **Important:** You must set `custom_subdomain_name` in Terraform. Without it, the account won't have a usable endpoint URL. Use the same randomized prefix you use for other resources.

### Terraform Hint

```hcl
resource "azurerm_cognitive_account" "azure_oai" {
  name                  = "${local.name_prefix}-aoai"
  location              = azurerm_resource_group.lab.location
  resource_group_name   = azurerm_resource_group.lab.name
  kind                  = "OpenAI"
  sku_name              = "S0"
  custom_subdomain_name = "${local.name_prefix}-aoai"
}
```

### Success Criteria
- You have created an Azure OpenAI account with a custom subdomain.
- The endpoint is accessible (e.g., `https://lab-3945-aoai.openai.azure.com/`).

---

## 7b - Model Deployment

### Objectives
- Create a Cognitive Deployment using:
    - `OpenAI` as model format
    - `gpt-4o-mini` as model name and deployment name
    - `2024-07-18` as model version
    - `Standard` as scale type
    - A capacity of **20**

> Capacity of 20 means 20,000 tokens per minute can be processed, or roughly 15,000 words if you are using English.

### Terraform Hint

```hcl
resource "azurerm_cognitive_deployment" "gpt_4o_mini" {
  name                 = "gpt-4o-mini"
  cognitive_account_id = azurerm_cognitive_account.azure_oai.id

  model {
    format  = "OpenAI"
    name    = "gpt-4o-mini"
    version = "2024-07-18"
  }

  scale {
    type     = "Standard"
    capacity = 20
  }
}
```

### Success Criteria
- You have deployed the `gpt-4o-mini` model.
- Add Terraform outputs for the endpoint:
  ```hcl
  output "aoai_endpoint" {
    value = azurerm_cognitive_account.azure_oai.endpoint
  }
  ```

---

## 7c - RBAC Role Assignment

In this training environment, **API key authentication is disabled** for Cognitive Services accounts. This is a security best practice enforced by organization policy. Instead, you will use **Entra ID (Azure AD) authentication** with a bearer token.

To call the OpenAI API with your user identity, you need a role assignment that grants the required data-plane permissions.

### Objectives
- Retrieve the Object ID of your current Azure AD user.
- Create a Role Assignment that grants the role `Cognitive Services OpenAI User` to your user on the OpenAI account.

> **Tip:** You can get the current user's Object ID using the `azurerm_client_config` data source:
> ```hcl
> data "azurerm_client_config" "current" {}
> ```
> Then use `data.azurerm_client_config.current.object_id` as the principal.

### Terraform Hint

```hcl
data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "aoai_user" {
  principal_id         = data.azurerm_client_config.current.object_id
  role_definition_name = "Cognitive Services OpenAI User"
  scope                = azurerm_cognitive_account.azure_oai.id
}
```

### Success Criteria
- The role assignment is created.
- After waiting **~2–5 minutes** for RBAC propagation, you can call the API using a bearer token.

---

## Verification

Since API key authentication is disabled in this environment, you have two verification options.

### Option A — Via the Azure Portal (easiest) 🌟

The Azure AI Studio playground lets you test your deployment directly in the browser — no tokens or CLI needed.

1. Open the [Azure Portal](https://portal.azure.com)
2. Navigate to your resource group and click on your **Azure OpenAI** resource
3. Click **Go to Azure AI Foundry portal** (or **Go to Azure OpenAI Studio**)
4. In the left menu, click **Chat**
5. Make sure your `gpt-4o-mini` deployment is selected
6. Type a message like _"Tell me about Azure Kubernetes Service"_ and press Send
7. You should see a response from the model — your deployment works! 🎉

### Option B — Via PowerShell with Entra ID bearer token

For a more advanced verification using the REST API:

```powershell
# Get the endpoint from Terraform
$ENDPOINT = terraform output -raw aoai_endpoint

# Get a bearer token for the Cognitive Services audience
$TOKEN = az account get-access-token --resource https://cognitiveservices.azure.com/ --query accessToken -o tsv

# Call the OpenAI API
$headers = @{
    "Authorization" = "Bearer $TOKEN"
    "Content-Type"  = "application/json"
}

$body = @{
    messages   = @(
        @{ role = "user"; content = "Tell me a short fact about Azure" }
    )
    max_tokens = 100
} | ConvertTo-Json -Depth 3

$response = Invoke-RestMethod `
    -Uri "${ENDPOINT}openai/deployments/gpt-4o-mini/chat/completions?api-version=2025-01-01-preview" `
    -Method POST `
    -Headers $headers `
    -Body $body

Write-Host "Model response: $($response.choices[0].message.content)"
```

You should see a response from the GPT-4o-mini model.

> **Troubleshooting:** If you get a `PermissionDenied` error, wait 2–5 minutes for RBAC propagation and try again. You may also need to refresh your token by re-running the `az account get-access-token` command.

> **Note on API version:** Use `api-version=2025-01-01-preview` or later. Older API versions (e.g., `2024-02-01`) may return authentication errors with bearer token auth.

---

## Common Mistakes

| Mistake | Symptom | Fix |
|---------|---------|-----|
| Missing `custom_subdomain_name` | No usable endpoint URL / empty endpoint | Add `custom_subdomain_name` to the `azurerm_cognitive_account` resource |
| Using deprecated `gpt-35-turbo-16k` | `ServiceModelDeprecated` error | Use `gpt-4o-mini` with version `2024-07-18` instead |
| Trying to use API keys | `AuthenticationTypeDisabled` error | Use Entra ID bearer tokens (see verification section above) |
| Missing role assignment | `PermissionDenied` (401) | Create a `Cognitive Services OpenAI User` role assignment for your user |
| RBAC not yet propagated | `PermissionDenied` after role assignment | Wait 2–5 minutes for Azure RBAC propagation, then refresh your token |
| Wrong API version | `PermissionDenied` with bearer token | Use `api-version=2025-01-01-preview` (not `2024-02-01`) |
| Capacity exceeds quota | `InsufficientQuota` error | Reduce capacity to 10 or check quota in Azure portal |

---

## Learning resources
- [azurerm_cognitive_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account)
- [azurerm_cognitive_deployment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_deployment)
- [Azure OpenAI Service REST API reference](https://learn.microsoft.com/en-us/azure/ai-services/openai/reference)
- [Authenticate with Azure OpenAI using Entra ID](https://learn.microsoft.com/en-us/azure/ai-services/openai/how-to/managed-identity)

## Sample solution
See [here](../../solutions/chapter-7/complete/).

---

## Stuck? Deploy the solution and continue

If you can't get your Terraform code to work, you can deploy the complete solution:

```powershell
# Replace <repo> with the path where you cloned the Cloud-Academy repo
Copy-Item -Force "<repo>\AzureBaseTraining\solutions\chapter-7\complete\*" C:\lab-solution\
cd C:\lab-solution
```

> **Important:** Copying these files will **overwrite** your `variables.tf`. You must re-set the `ssh_key` variable to your SSH public key (see Chapter 3 for instructions).

```powershell
terraform init
terraform apply    # ~5-10 min
```

After deploy, verify via the Azure Portal (see Verification section above).

---

**[< back](../chapter-5/README.md) | [home](../README.md)**
