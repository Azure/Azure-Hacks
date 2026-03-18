output "jumphost_pip" {
  value = azurerm_linux_virtual_machine.vm.public_ip_address
}

output "acr_name" {
  value = azurerm_container_registry.acr.name
}