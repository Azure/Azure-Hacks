output "jumphost_pip" {
  value = azurerm_linux_virtual_machine.vm.public_ip_address
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