# Chapter 1 - Azure Container Registry (ACR)

## What is ACR?

Azure Container Registry (ACR) is a **private Docker registry** hosted in Azure. Instead of pushing your images to Docker Hub (public), you push them to your own private ACR.

```
Your Laptop                          Azure
┌─────────────┐                     ┌──────────────────┐
│ docker build│  ── docker push ─>  │  ACR             │
│ my-app:v1   │                     │  my-app:v1       │
└─────────────┘                     │                  │
                                    │ (private, secure)│
                                    └────────┬─────────┘
                                             │
                                    AKS, App Service, etc.
                                    pull images from here
```

### Why use ACR instead of Docker Hub?

| Feature | Docker Hub (free) | ACR |
|---|---|---|
| Privacy | Public by default | Private by default |
| Location | US-based | Same Azure region as your apps (low latency) |
| Auth | Username/password | Entra ID (Azure AD), managed identities |
| Build | No | Yes — ACR can build images for you (no Docker needed locally!) |
| Integration | Manual | Native integration with AKS, App Service, etc. |

### ACR SKUs

| SKU | Use case | Storage | Features |
|---|---|---|---|
| **Basic** | Dev/test, learning | 10 GB | Core features |
| **Standard** | Most production workloads | 100 GB | More throughput |
| **Premium** | Enterprise | 500 GB | Geo-replication, private endpoints |

---

## Hands-On: Create an ACR and Push an Image

### Step 1 — Create a Resource Group and ACR

First, create a resource group for this lab (or use an existing one from Day 1):

```powershell
# Set your variables
$RG = "rg-day4-containers"
$ACR_NAME = "youraliasacr"   # Must be globally unique, only letters and numbers (no dashes/underscores)
$LOCATION = "swedencentral"

# Create a resource group (skip if reusing one from Day 1)
az group create --name $RG --location $LOCATION
```

Now create the ACR:

```powershell
az acr create `
  --resource-group $RG `
  --name $ACR_NAME `
  --sku Basic `
  --admin-enabled false `
  --location $LOCATION
```

Verify it was created:

```powershell
az acr show --name $ACR_NAME --query "{name:name, loginServer:loginServer, sku:sku.name}" -o table
```

### Step 2 — Log in to your ACR

```powershell
az acr login --name $ACR_NAME
```

This configures Docker to authenticate with your registry using your Azure credentials.

> **If Docker is not running**, you'll see a `DOCKER_COMMAND_ERROR`. You can still authenticate using a token:
> ```powershell
> az acr login --name $ACR_NAME --expose-token
> ```
> This returns an access token you can use for API calls. The `az acr build` command in Step 5 works without Docker.

### Step 3 — Tag and push a local image

If you built the `my-web-app:v1` image in chapter-0:

```powershell
# Tag the image for your ACR
docker tag my-web-app:v1 "$ACR_NAME.azurecr.io/my-web-app:v1"

# Push it
docker push "$ACR_NAME.azurecr.io/my-web-app:v1"
```

### Step 4 — Verify the image is in ACR

```powershell
# List repositories in your ACR
az acr repository list --name $ACR_NAME -o table

# Show tags for the image
az acr repository show-tags --name $ACR_NAME --repository my-web-app -o table
```

### Step 5 — Build an image directly in ACR (no Docker needed!)

ACR can build images from source code — you don't even need Docker installed for this.

**Option A — Build from a local Dockerfile:**

Create a simple test app:

```powershell
mkdir C:\acr-build-demo
cd C:\acr-build-demo
```

```powershell
@"
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
"@ | Set-Content -Path "Dockerfile" -Encoding UTF8

@"
<!DOCTYPE html>
<html><body><h1>Hello from ACR Build!</h1></body></html>
"@ | Set-Content -Path "index.html" -Encoding UTF8
```

```powershell
az acr build --registry $ACR_NAME --image my-web-app:v1 --file Dockerfile .
```

> **Important:** ACR Build runs on **Linux** containers in the cloud. Use Linux-based base images (e.g., `nginx:alpine`, `node:lts-alpine`) in your Dockerfile — Windows-based images like `nanoserver` are not supported by ACR Build.

**Option B — Build from a GitHub repo:**

```powershell
az acr build `
  --registry $ACR_NAME `
  --image go-probe:latest `
  --platform linux/amd64 `
  https://github.com/joergjo/go-probe.git
```

> **Note:** If you just created the ACR (within the last minute), the first ACR Build may fail with a DNS resolution error like `no such host`. This is because DNS propagation for the new registry takes ~30–60 seconds. Simply wait a minute and try again.

Both options pull the source code, build the Docker image **in the cloud**, and store it in your ACR.

Verify:

```powershell
az acr repository list --name $ACR_NAME -o table
az acr repository show-tags --name $ACR_NAME --repository my-web-app -o table
```

You should see your image(s) listed.

---

## Key Concepts Recap

| Concept | What it means |
|---|---|
| **Registry** | A storage service for container images (ACR, Docker Hub) |
| **Repository** | A collection of related images with the same name (e.g., `my-web-app`) |
| **Tag** | A version label for an image (e.g., `v1`, `latest`) |
| **Login server** | The URL of your ACR: `yourname.azurecr.io` |
| **ACR Build** | Build images in the cloud without needing Docker locally |

---

## Learning Resources

- [What is Azure Container Registry?](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-intro)
- [Quickstart: Create a container registry using the Azure CLI](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-get-started-azure-cli)
- [Build and push images with ACR Tasks](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-quickstart-task-cli)

---

**[< back](../chapter-0/README.md) | [next: AKS >](../chapter-2/README.md)**
