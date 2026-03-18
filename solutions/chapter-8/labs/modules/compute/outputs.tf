output "vm_id" {
  value = azurerm_linux_virtual_machine.vm.id
}

output "jumphost_pip" {
  value = azurerm_linux_virtual_machine.vm.public_ip_address
}