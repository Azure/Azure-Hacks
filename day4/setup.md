# Setup - Containerization Tools

This page walks you through verifying the tools you need for the containerization module. Most tools were installed during [Day 1 - Chapter 0](../day1/chapter-0/README.md). Complete each verification step before moving on.

---

## 1. Azure CLI

You should already have this from Day 1. Verify:

```powershell
az --version
```

> If not installed, refer to [Day 1 - Chapter 0](../day1/chapter-0/README.md) or see: https://learn.microsoft.com/en-us/cli/azure/install-azure-cli

### Log in and set your subscription

```powershell
az login
az account set --subscription <your-subscription-id>
az account show --query "{name:name, id:id}" -o table
```

---

## 2. Docker Desktop

Docker lets you build and run containers on your local machine.

### Install

Download and install from: https://docs.docker.com/desktop/install/windows-install/

> **Important:** Choose the correct installer for your machine's architecture:
> - **x64 (Intel/AMD)** — most standard laptops and desktops
> - **ARM64** — Surface Pro X, Dev Box with ARM, or other ARM-based Windows devices
>
> If you see an error like "cannot install the Intel (x64) version on ARM64 Windows", download the ARM64 installer instead.

> After installation, you may need to restart your computer. Docker Desktop must be running for `docker` commands to work.

### Verify

```powershell
docker --version
```

Expected output (version may vary):
```
Docker version 29.x.x, build xxxxxxx
```

Test that Docker can run containers:

```powershell
docker run --rm hello-world
```

You should see a message starting with "Hello from Docker!" — this confirms Docker can pull images and run containers.

---

## 3. kubectl (Kubernetes CLI)

kubectl is the command-line tool for interacting with Kubernetes clusters. You will use it throughout this module to deploy applications, inspect pods, view logs, and more.

### What is kubectl?

kubectl sends commands to the Kubernetes API server — the brain of any Kubernetes cluster. Every action you take on a cluster (deploy an app, check status, read logs) goes through kubectl.

```
You (kubectl) ──> Kubernetes API Server ──> Nodes/Pods/Services
```

### Install

There are two ways to install kubectl on Windows. Pick one:

**Option A — Via Azure CLI (recommended)**

This installs the version that matches Azure Kubernetes Service:

```powershell
az aks install-cli
```

> This command installs both `kubectl` and `kubelogin` (used for Azure AD authentication with AKS). You may need to **restart your terminal** after installation for the PATH to update.

**Option B — Via the official Kubernetes release**

```powershell
# Download the latest kubectl binary
curl.exe -LO "https://dl.k8s.io/release/v1.31.0/bin/windows/amd64/kubectl.exe"

# Move it to a folder in your PATH (e.g., C:\kubectl\)
New-Item -ItemType Directory -Force -Path "C:\kubectl"
Move-Item -Force kubectl.exe "C:\kubectl\kubectl.exe"

# Add to PATH (for the current session)
$env:PATH += ";C:\kubectl"

# To make it permanent, add C:\kubectl to your System PATH via:
# Settings > System > About > Advanced system settings > Environment Variables > Path > Edit > New > C:\kubectl
```

### Verify

Open a **new terminal** (important — PATH changes require a new session) and run:

```powershell
kubectl version --client
```

Expected output:
```
Client Version: v1.31.x
```

> You will see a connection warning for the server part — that's expected. You don't have a cluster yet; kubectl is just installed and ready.

### Quick test

You can confirm kubectl is functional by asking it to list its available commands:

```powershell
kubectl --help
```

You should see a list of commands grouped by category (Basic, Deploy, Cluster Management, etc.).

---

## 4. Terraform

You should already have this from Day 1. Verify:

```powershell
terraform version
```

> If not installed, refer to [Day 1 - Chapter 0](../day1/chapter-0/README.md) or see: https://learn.hashicorp.com/tutorials/terraform/install-cli

---

## 5. (Optional) VS Code Extensions

If you haven't already, install these VS Code extensions for a better experience:

- **Docker** (`ms-azuretools.vscode-docker`) — Dockerfile syntax, image management
- **Kubernetes** (`ms-kubernetes-tools.vscode-kubernetes-tools`) — cluster explorer, manifest editing
- **HashiCorp Terraform** (`hashicorp.terraform`) — Terraform syntax and autocomplete

You can install them from the Extensions sidebar in VS Code or via command line:

```powershell
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
code --install-extension hashicorp.terraform
```


## Checklist

Before proceeding, confirm all of these work:

| Tool | Command | Expected |
|---|---|---|
| Azure CLI | `az --version` | 2.x.x |
| Docker | `docker --version` | 27.x or newer |
| kubectl | `kubectl version --client` | v1.31.x or newer |
| Terraform | `terraform version` | 1.5+ |

Once everything checks out, proceed to [Chapter 0: Container Fundamentals](./chapter-0/README.md).

---

**[< back](./README.md)**
