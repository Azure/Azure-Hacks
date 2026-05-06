# Create an Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                = "${replace(var.name_prefix, "-", "")}images"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = false
}

# Create an Azure Kubernetes Service cluster
resource "azurerm_kubernetes_cluster" "k8s" {
  location            = var.location
  name                = "${var.name_prefix}-cluster"
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.name_prefix}-aks"
  kubernetes_version  = var.k8s_version

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name                = "agentpool1"
    vm_size             = "Standard_D2ads_v5"
    node_count          = 3
    zones               = ["1", "2", "3"]
    enable_auto_scaling = false
    os_disk_type        = "Ephemeral"
    os_disk_size_gb     = 70
    vnet_subnet_id      = var.subnet_id
  }

  linux_profile {
    admin_username = "YWRtaW51c2VyC"

    ssh_key {
      key_data = file(var.ssh_key)
    }
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "azure"
    pod_cidr            = "192.168.0.0/16"
    load_balancer_sku   = "standard"
  }
}

# Create a role assignment for the AKS cluster to pull images from the ACR
resource "azurerm_role_assignment" "acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}