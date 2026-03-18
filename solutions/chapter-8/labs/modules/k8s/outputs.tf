output "k8s_id" {
  value = azurerm_kubernetes_cluster.k8s.id
}

output "acr_name" {
  value = azurerm_container_registry.acr.name
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config_raw
  sensitive = true
}