# Chapter 2 - Azure Kubernetes Service (AKS)

## What is Kubernetes?

Kubernetes (K8s) is an **orchestration platform** for containers. When you have many containers running an application, Kubernetes manages:

- **Where** containers run (across multiple machines)
- **How many** copies run (scaling)
- **What happens** when a container crashes (auto-restart)
- **How traffic** reaches containers (networking / load balancing)
- **Rolling updates** (deploy new versions without downtime)

Think of it this way:
- **Docker** = runs ONE container on ONE machine
- **Kubernetes** = runs MANY containers across MANY machines, automatically

## What is AKS?

Azure Kubernetes Service (AKS) is a **managed Kubernetes** service. Azure handles:
- The control plane (API server, scheduler, etc.) — **free**
- OS patching and upgrades of nodes
- Monitoring and diagnostics integration

You only pay for the **worker nodes** (VMs) that run your containers.

```
┌──────────────────────────────────────────────────┐
│                   AKS Cluster                    │
│                                                  │
│  ┌──────────────┐    Managed by Azure (free)     │
│  │ Control Plane│   API Server, Scheduler, etcd  │
│  └──────┬───────┘                                │
│         │                                        │
│  ┌──────┴───────────────────────────────────┐    │
│  │           Node Pool (your VMs)           │    │
│  │  ┌─────────┐ ┌─────────┐ ┌─────────┐     │    │
│  │  │ Node 1  │ │ Node 2  │ │ Node 3  │     │    │
│  │  │┌──┐┌──┐ │ │┌──┐┌──┐ │ │┌──┐┌──┐ │     │    │
│  │  ││P1││P2│ │ ││P3││P4│ │ ││P5││P6│ │     │    │
│  │  │└──┘└──┘ │ │└──┘└──┘ │ │└──┘└──┘ │     │    │
│  │  └─────────┘ └─────────┘ └─────────┘     │    │
│  └──────────────────────────────────────────┘    │
│                You pay for these                 │
└──────────────────────────────────────────────────┘

P = Pod (one or more containers)
```

### Key Kubernetes Terms

| Term | What it is |
|---|---|
| **Cluster** | The entire Kubernetes environment (control plane + nodes) |
| **Node** | A VM that runs containers |
| **Pod** | The smallest unit — wraps one or more containers |
| **Deployment** | Defines how many Pods to run and which image to use |
| **Service** | Gives Pods a stable network address (Pods are ephemeral) |
| **Namespace** | A logical partition inside a cluster (like folders) |
| **kubectl** | CLI to interact with the cluster |

---

## Hands-On: Deploy an AKS Cluster

We will use the Terraform configuration from the [basic_tf](https://github.com/jeffreygroneberg/basic_tf) repository to create an AKS cluster. This is the same repo you cloned in Day 1 — now we'll use the `aks/` folder.

### Step 1 — Clone the repo (if you haven't already)

```powershell
# If you already cloned it in Day 1, skip this step
git clone https://github.com/jeffreygroneberg/basic_tf.git C:\basic_tf
```

### Step 2 — Review the Terraform files

Open the `aks/` folder and look at the files:

```powershell
cd C:\basic_tf\aks
```

| File | Purpose |
|---|---|
| `main.tf` | Defines the AKS cluster: resource group, cluster config, node pool, network settings |
| `ssh.tf` | Auto-generates an SSH key pair via Azure API (no manual key needed) |
| `outputs.tf` | Prints the cluster name, resource group, and credentials after creation |

Key things the `main.tf` creates:
- A **resource group** (`rg-example-aks`)
- An **AKS cluster** with 1 node (`Standard_D2ads_v6`), managed identity, and kubenet networking
- A **randomly generated name** for the cluster (using `random_pet`)

> **⚠️ Known Issue — VM Size:** The default `main.tf` uses `Standard_D2_v2` which may **not be available** in your subscription. Before deploying, open `main.tf` and update the `vm_size` in the `default_node_pool` block to an allowed size. A safe choice for most subscriptions is:
> ```hcl
> vm_size = "Standard_D2s_v6"
> ```
> If you get a `BadRequest` error about VM sizes during `terraform apply`, check the error message — it lists all available VM sizes for your subscription and region.

> **💡 Tip — Save costs:** The default configuration creates 3 nodes. For learning purposes, you can change `node_count` to `1` to save costs. The lab works fine with a single node.

> **Note:** The `basic_tf` repo deploys the AKS cluster to `West Europe`. Your ACR from Chapter 1 is in `swedencentral`. This is fine — cross-region image pulls work, just slightly slower. The `az aks check-acr` command may show a location mismatch warning, which you can safely ignore.

### Step 3 — Deploy the cluster with Terraform

```powershell
cd C:\basic_tf\aks

# Initialize Terraform (downloads providers)
terraform init

# Preview what will be created
terraform plan

# Apply — type "yes" when prompted
terraform apply
```

> **⏱️ This creates a VM as a worker node, so it will take a few minutes.** Wait for it to complete. If you see an error, check the [Troubleshooting](#troubleshooting) section at the bottom.

When finished, Terraform will output the cluster name and resource group. Note these values — you'll need them.

```powershell
# View the outputs
terraform output resource_group_name
terraform output kubernetes_cluster_name
```

### Step 4 — Connect kubectl to your cluster

```powershell
# Get the values from terraform output
$RG = $(terraform output -raw resource_group_name)
$CLUSTER_NAME = $(terraform output -raw kubernetes_cluster_name)

# Download credentials and configure kubectl
az aks get-credentials --resource-group $RG --name $CLUSTER_NAME --overwrite-existing
```

This downloads the cluster's certificate and configures kubectl to talk to your AKS cluster.

Verify the connection:

```powershell
kubectl cluster-info
kubectl get nodes
```

You should see one node in `Ready` state.

### Step 5 — Explore the cluster

```powershell
# List namespaces (Kubernetes built-in partitions)
kubectl get namespaces

# List all pods across all namespaces (system pods running the cluster)
kubectl get pods --all-namespaces

# Get detailed info about your nodes
kubectl describe node
```

---

## Deploy an Application to AKS

### Step 6 — Connect AKS to your ACR

So AKS can pull images from your private ACR:

```powershell
$ACR_NAME = "youraliasacr"  # same name from chapter-1

az aks update `
  --resource-group $RG `
  --name $CLUSTER_NAME `
  --attach-acr $ACR_NAME
```

This grants the AKS cluster's managed identity the `AcrPull` role on your ACR — no passwords needed.

> **Note:** If your ACR and AKS cluster are in different Azure regions (e.g., ACR in `swedencentral`, AKS in `westeurope`), image pulls will still work but may be slightly slower. For production, keep them in the same region.

Verify the attachment worked:

```powershell
az aks check-acr --resource-group $RG --name $CLUSTER_NAME --acr $ACR_NAME.azurecr.io 2>&1 | Select-String "SUCCEEDED|FAILED"
```

### Step 6b — Quick test: Deploy nginx to verify the cluster works

Before deploying from ACR, let's verify the cluster can run a basic deployment:

```powershell
# Deploy nginx (from public Docker Hub)
kubectl create deployment nginx-test --image=nginx --replicas=2

# Expose it with a LoadBalancer (gives it a public IP)
kubectl expose deployment nginx-test --type=LoadBalancer --port=80

# Wait ~30 seconds for the external IP to be assigned, then check:
kubectl get svc nginx-test
```

Once `EXTERNAL-IP` shows an IP address (not `<pending>`), open it in your browser — you should see the Nginx welcome page!

```powershell
# Clean up the test deployment
kubectl delete deployment nginx-test
kubectl delete svc nginx-test
```

### Step 7 — Deploy the go-probe app

First, generate a CSRF key (required by the go-probe app):

```powershell
$CSRF_KEY = -join ((1..48) | ForEach-Object { '{0:x}' -f (Get-Random -Max 16) })
```

Create a file called `app.yaml` by replacing 2 variables:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: go-probe
spec:
  replicas: 1
  selector:
    matchLabels:
      app: go-probe
  template:
    metadata:
      labels:
        app: go-probe
    spec:
      containers:
        - name: go-probe
          image: youraliasacr.azurecr.io/go-probe:latest   # <-- replace with your ACR name
          ports:
            - containerPort: 8080
              name: http
          env:
            - name: GO_PROBE_CSRF_KEY
              value: "REPLACE_WITH_CSRF_KEY"                # <-- replace with your $CSRF_KEY value
            - name: GO_PROBE_DEVELOPER_MODE
              value: "true"
          resources:
            requests:
              cpu: 200m
              memory: 200Mi
            limits:
              cpu: 200m
              memory: 200Mi
      nodeSelector:
        kubernetes.io/os: linux
---
apiVersion: v1
kind: Service
metadata:
  name: go-probe
spec:
  type: ClusterIP
  ports:
    - port: 8080
      targetPort: http
      name: http
  selector:
    app: go-probe
```

Apply it:

```powershell
kubectl apply -f app.yaml
```

### Step 8 — Check the deployment

```powershell
# See the deployment
kubectl get deployments

# See the pod (wait until STATUS is Running)
kubectl get pods

# See the service
kubectl get services
```

### Step 9 — Access the application

Since we used `ClusterIP` (internal only), use port-forwarding to access it from your laptop:

```powershell
kubectl port-forward svc/go-probe 8080:8080
```

Open http://localhost:8080 — you should see the go-probe test application!

Press `Ctrl+C` to stop port-forwarding.

---

## What Just Happened?

```
1. You built an image           →  stored in ACR (chapter-1)
2. You deployed AKS via Terraform (basic_tf/aks)  →  Kubernetes running in Azure
3. You connected kubectl to the cluster  →  az aks get-credentials
4. AKS pulled the image from ACR (passwordless via managed identity)
5. Kubernetes created a Pod running your container
6. A Service gave the Pod a stable internal address
7. port-forward created a tunnel from localhost to the cluster
```

---

## Clean Up

When you're done experimenting:

```powershell
# Delete just the app from the cluster
kubectl delete -f app.yaml

# Or destroy the entire AKS cluster (from the basic_tf/aks folder)
cd C:\basic_tf\aks
terraform destroy
```

> **💡 Tip:** `terraform destroy` will prompt for confirmation. Type `yes` to proceed. This deletes the resource group, AKS cluster, and all associated resources.

---

## Troubleshooting

### `Standard_D2_v2` VM size not available

**Error:** `The VM size of Standard_D2_v2 is not allowed in your subscription in location 'westeurope'`

**Fix:** Open `C:\basic_tf\aks\main.tf`, find the `default_node_pool` block, and change `vm_size` to one of the allowed sizes listed in the error message. Recommended: `Standard_D2s_v6`. Then run `terraform apply` again.

### Terraform state lock error

**Error:** `Error acquiring the state lock` or `The process cannot access the file because another process has locked a portion of the file`

**Fix:** Another Terraform process may be running. Close all other terminals, then:
```powershell
Stop-Process -Name terraform -Force -ErrorAction SilentlyContinue
```
Then retry `terraform apply`.

### `az acr login` fails with DOCKER_COMMAND_ERROR

**Error:** `failed to connect to the docker API`

**Fix:** Docker Desktop is not running. Either start Docker Desktop, or use `az acr login --name $ACR_NAME --expose-token` instead. The `az acr build` and `az aks update --attach-acr` commands work without Docker.

### Pods in CrashLoopBackOff or ImagePullBackOff

- **CrashLoopBackOff**: The container starts but exits immediately. Check logs: `kubectl logs <pod-name>`
- **ImagePullBackOff**: AKS can't pull the image from ACR. Verify the ACR attachment: `az aks check-acr --resource-group $RG --name $CLUSTER_NAME --acr $ACR_NAME.azurecr.io`

---

## kubectl Cheat Sheet

```powershell
# Cluster
kubectl cluster-info                    # Cluster endpoint info
kubectl get nodes                       # List nodes

# Workloads
kubectl get pods                        # List pods in default namespace
kubectl get pods -A                     # List pods in ALL namespaces
kubectl get deployments                 # List deployments
kubectl describe pod <pod-name>         # Detailed pod info
kubectl logs <pod-name>                 # View container logs
kubectl logs <pod-name> -f             # Follow/stream logs

# Services & Networking
kubectl get services                    # List services
kubectl port-forward svc/<name> 8080:8080  # Tunnel to a service

# Apply & Delete
kubectl apply -f <file.yaml>           # Create/update resources from file
kubectl delete -f <file.yaml>          # Delete resources defined in file

# Debugging
kubectl exec -it <pod-name> -- /bin/sh # Open a shell inside a pod
kubectl get events                      # See cluster events
```

---

## Learning Resources

- [What is AKS?](https://learn.microsoft.com/en-us/azure/aks/intro-kubernetes)
- [Quickstart: Deploy an AKS cluster using Azure CLI](https://learn.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-cli)
- [Kubernetes Basics (official tutorial)](https://kubernetes.io/docs/tutorials/kubernetes-basics/)
- [kubectl Cheat Sheet (official)](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

---

**[< back](../chapter-1/README.md) | [next: ACR Lab (Terraform) >](../chapter-3/README.md)**
