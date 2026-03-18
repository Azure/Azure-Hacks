output "jumphost_pip" {
  value = azurerm_linux_virtual_machine.vm.public_ip_address
}