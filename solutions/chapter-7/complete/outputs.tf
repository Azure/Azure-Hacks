output "jumphost_pip" {
  value = azurerm_linux_virtual_machine.vm.public_ip_address
}

output "resource_group_name" {
  value = azurerm_resource_group.lab.name
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.k8s.name
}

output "acr_name" {
  value = azurerm_container_registry.acr.name
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config_raw
  sensitive = true
}

output "pg_password" {
  value     = random_password.pg_password.result
  sensitive = true
}

output "aoai_endpoint"  {
  value = azurerm_cognitive_account.azure_oai.endpoint
}

# Note: API key auth is disabled in this environment (disableLocalAuth=true).
# Use Entra ID bearer tokens instead. See chapter-6/README.md for details.
