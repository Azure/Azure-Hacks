output "azurerm_resource_group" {

  description = "The created resource group."
  value       = azurerm_resource_group.rg

}

output "vm" {

  description = "The created virtual machine."
  value       = azurerm_linux_virtual_machine.vm1

}

output "vnet" {

  description = "The created virtual network."
  value       = azurerm_virtual_network.vnet

}

output "subnet" {

  description = "The created subnet."
  value       = azurerm_subnet.subnet

}
