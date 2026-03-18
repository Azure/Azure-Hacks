# Create a private DNS zone for PostgreSQL
resource "azurerm_private_dns_zone" "private_dns" {
  name                = "${var.name_prefix}.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}

# Create a virtual network link to the private DNS zone
resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_vnet_link" {
  name                  = "${var.name_prefix}-vnet-link"
  private_dns_zone_name = azurerm_private_dns_zone.private_dns.name
  virtual_network_id    = var.vnet_id
  resource_group_name   = var.resource_group_name
}

# Create an Azure Database for PostgreSQL Flexible Server
resource "azurerm_postgresql_flexible_server" "postgres" {
  name                          = "${var.name_prefix}-postgres"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "15"
  sku_name                      = "B_Standard_B1ms"
  zone                          = "1"
  storage_mb                    = 32768
  auto_grow_enabled             = true
  backup_retention_days         = 7
  administrator_login           = "flexadmin"
  administrator_password        = var.pg_password
  public_network_access_enabled = false
  delegated_subnet_id           = var.subnet_id
  private_dns_zone_id           = azurerm_private_dns_zone.private_dns.id

  depends_on = [azurerm_private_dns_zone_virtual_network_link.private_dns_vnet_link]
}