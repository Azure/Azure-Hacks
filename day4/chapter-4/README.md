# Chapter 4 - Lab: AKS with Terraform

> This lab is adapted from the Day 3 advanced lab (Chapter 5, ch-05). It provides a Terraform-based challenge for deploying a full AKS cluster with ACR integration after you've learned the concepts in the earlier chapters.

---

## Prerequisites

Before starting this lab, make sure you have:
- Completed **Chapter 3** (ACR is created and `go-probe:latest` image is built)
- Your Terraform project from Chapter 3 (you'll add AKS resources to it)
- `kubectl` installed (`kubectl version --client` to verify)
- The `kubernetes` subnet created in your virtual network from previous labs

> **⏱️ Time estimate:** The AKS cluster creation step takes **~5–10 minutes** via Terraform. Plan accordingly.

---

# 5 - Kubernetes
Instead of running applications on virtual machines, higher level services such as Kubernetes or Azure App Services are often the preferred solution to run your applications in Azure. 

## 5a - Azure Kubernetes Service
Create an Azure Kubernetes Service (AKS) cluster so you can run containerized applications.

### Objectives
- Create an AKS cluster.
- Place the cluster in your existing resource group in Sweden Central.
- Use Kubernetes version `1.32.11`.

> **Tip:** Kubernetes versions change frequently. To check which versions are currently available in your region, run:
> ```powershell
> az aks get-versions --location swedencentral --query "values[].patchVersions | [].keys(@)[]" -o tsv | Sort-Object
> ```
> If `1.32.11` is no longer available, pick the latest patch version from the list.
- Use a system-assigned identity for the cluster.
- Randomize the cluster's name and DNS name the same way you have randomized your resource group's name.
- For the default node pool use the following settings:
    - Set `agentpool1` as name.
    - Size the pool to contain three VMs.
    - Use `Standard_D2ads_v5` as VM size.
    - Place the three VMs in different availability zones.
    - Disable the cluster autoscaler
    - Use `Ephemeral` OS disks.
    - Set the OS disk size to 70 GB.
    - Attach the node pool to the `kubernetes` subnet you have created previously.
- For the network profile use the following settings:
    - Network plugin: `azure`
    - Network plugin mode: `overlay`
    - Network policy: `azure`
    - Pod CIDR: `192.168.0.0/16`
    - Load Balancer SKU: `standard` 
- For the Linux profile, use `YWRtaW51c2VyC` as admin username and the SSH key you have created previously.


### Success Criteria
- You have created an AKS cluster.
- All 3 nodes are in `Ready` state.

> **After `terraform apply` completes**, verify your cluster is healthy:
> ```powershell
> # Get the cluster name and resource group from Terraform outputs
> $CLUSTER = terraform output -raw kubernetes_cluster_name   # or your output name
> $RG = terraform output -raw resource_group_name
>
> # Download credentials
> az aks get-credentials -n $CLUSTER -g $RG --overwrite-existing
>
> # Check nodes
> kubectl get nodes
> ```
> You should see 3 nodes in `Ready` state. If not, wait a minute and try again.

### Terraform Hint

```hcl
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "your-aks-name"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "your-dns-prefix"
  kubernetes_version  = "1.32.11"

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name                = "agentpool1"
    node_count          = 3
    vm_size             = "Standard_D2ads_v5"
    zones               = [1, 2, 3]
    os_disk_type        = "Ephemeral"
    os_disk_size_gb     = 70
    vnet_subnet_id      = azurerm_subnet.kubernetes.id
    enable_auto_scaling = false
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "azure"
    pod_cidr            = "192.168.0.0/16"
    load_balancer_sku   = "standard"
  }
}
```

## 5b - Passwordless Access to ACR
The container registry you have created previously is not a public registry that allows anonymous access. While we could provide a username and password provided by the ACR to Kubernetes so it can pull images, we'd rather want _passwordless_ access, i.e., we'd like to authorize the AKS cluster resource's identity to be able to access the ACR through access tokens issued by Entra ID.

### Objectives
- Create a Role Assignment that grants the role `AcrPull` to the AKS resource's `kubelet` identity on your ACR.
- Assign the role at the smallest scope possible.

> **Tip:** In your Terraform code, add this attribute to the role assignment resource: `skip_service_principal_aad_check = true`. This is needed because the kubelet identity is a service principal, and Terraform needs to skip the Azure AD check to avoid a race condition during creation.

### Terraform Hint

```hcl
resource "azurerm_role_assignment" "aks_acr" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}
```

### Success Criteria
- The `kubelet` identity can pull images from the ACR.
- You can deploy the test application using the image stored in your ACR.

### Verification
On your PowerShell terminal run the following command:

```powershell
# Set environment variables
# Replace "youraks" with your cluster's name,
# "yourrg" with your resource group's name, and
# "youracr" with your ACR's name
$env:CLUSTER = "youraks"
$env:RG = "yourrg"
$env:ACR = "youracr" 
$env:CSRF_KEY = -join ((1..48) | ForEach-Object { '{0:x}' -f (Get-Random -Max 16) })

# If you have openssl installed, you can alternatively use:
# $env:CSRF_KEY = openssl rand -hex 24

# Download certificate to access your cluster
az aks get-credentials -n $env:CLUSTER -g $env:RG

# Deploy the test application
@"
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
          image: ${env:ACR}.azurecr.io/go-probe:latest
          ports:
            - containerPort: 8080
              name: http
          env:
            - name: GO_PROBE_CSRF_KEY
              value: ${env:CSRF_KEY}
            - name: GO_PROBE_DEVELOPER_MODE
              value: "true"
          livenessProbe:
            httpGet:
              path: /
              port: http
            initialDelaySeconds: 5
            periodSeconds: 30
          readinessProbe:
            httpGet:
              path: /
              port: http
            initialDelaySeconds: 5
            periodSeconds: 30
          resources:
            requests:
              cpu: 200m
              memory: 200Mi
            limits:
              cpu: 200m
              memory: 200Mi
      nodeSelector:
        "kubernetes.io/os": linux
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
"@ | kubectl apply -f-

# Create a tunnel to our service in Kubernetes
kubectl port-forward svc/go-probe 8080:8080
```

The last command creates a secure tunnel from your local computer to the AKS cluster. Open http://localhost:8080 and you will be able to access the test application without exposing it to the internet!

> **Tip:** If port 8080 is already in use, change it to another port: `kubectl port-forward svc/go-probe 9090:8080` and then open http://localhost:9090.

Keep `kubectl port-forward` running, you will continue to use the test application in later steps.

### Verifying the deployment step-by-step

If something doesn't work, check each component:

```powershell
# 1. Are the pods running?
kubectl get pods
# Expected: go-probe pod with STATUS "Running" and READY "1/1"

# 2. If pod is in ImagePullBackOff — ACR pull permission issue
kubectl describe pod <pod-name>   # Look at Events section

# 3. If pod is in CrashLoopBackOff — app is crashing
kubectl logs <pod-name>           # Check application logs

# 4. Is the service created?
kubectl get svc go-probe
# Expected: ClusterIP service on port 8080
```

## Common Mistakes

| Mistake | Symptom | Fix |
|---------|---------|-----|
| K8s version doesn't exist | `VMSizeNotSupportedForKubernetesVersion` or version error | Run `az aks get-versions --location swedencentral` to find valid versions |
| Wrong subnet reference | `SubnetNotFound` or `InvalidParameter` | Verify `vnet_subnet_id` points to the `kubernetes` subnet, not the `default` one |
| Missing ACR role assignment | Pods stuck in `ImagePullBackOff` | Add the `azurerm_role_assignment` with `AcrPull` role |
| SSH key not set | `linux_profile` validation error | Generate a key with `ssh-keygen` or remove `linux_profile` block (it's optional for AKS) |
| Node pool name too long | Validation error | Node pool name must be 1-12 characters, lowercase alphanumeric |

## Learning resources
- [azurerm_kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster)
- [Quickstart: Deploy an Azure Kubernetes Service (AKS) cluster using Terraform](https://learn.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-terraform?pivots=development-environment-azure-cli)

## Sample solution
See [here](../../solutions/chapter-7/ch-05/).

---

## Stuck? Deploy the solution and continue

If you can't get your Terraform code to work, you can deploy the provided solution and move on:

```powershell
# Copy the solution to your working directory
# Replace <repo> with the path where you cloned the Cloud-Academy repo
Copy-Item -Force "<repo>\AzureBaseTraining\solutions\chapter-7\ch-05\*" C:\lab-solution\
cd C:\lab-solution
```

> **Important:** Copying these files will **overwrite** your `variables.tf`. You must re-set the `ssh_key` variable to your SSH public key (see Chapter 3 for instructions).
> If you already deployed the Chapter 3 solution, this will ADD AKS to the same resource group.

```powershell
terraform init
terraform apply    # ~5-10 min for AKS
```

After deploy, connect to the cluster and build the go-probe image:

```powershell
$RG = terraform output -raw resource_group_name
$CLUSTER = terraform output -raw kubernetes_cluster_name
$ACR = terraform output -raw acr_name
az aks get-credentials -n $CLUSTER -g $RG --overwrite-existing
az acr build -r $ACR -t go-probe:latest --platform linux/amd64 https://github.com/joergjo/go-probe.git
```

Then continue with [Chapter 5](../chapter-5/README.md).

---

**[< back](../chapter-3/README.md) | [next: PostgreSQL Lab >](../chapter-5/README.md)**
