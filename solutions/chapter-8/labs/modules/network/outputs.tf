output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_1_name" {
  value = azurerm_subnet.subnet_1.name
}

output "subnet_2_name" {
  value = azurerm_subnet.subnet_2.name
}

output "subnet_3_name" {
  value = azurerm_subnet.subnet_3.name
}