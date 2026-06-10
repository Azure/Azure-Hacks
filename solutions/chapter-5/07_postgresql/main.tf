# Short random suffix used in every resource name so participants can run
# the lab side-by-side without collisions. The PostgreSQL server name
# becomes part of a globally-unique FQDN (`<name>.postgres.database.azure.com`)
# so uniqueness matters.
resource "random_pet" "id" {
  length    = 2
  separator = "-"
}

# Strong random password for the PG admin account. Kept in Terraform state
# only; we expose it through a `sensitive` output below.
resource "random_password" "admin" {
  length           = 24
  special          = true
  override_special = "_-"
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-pg-${random_pet.id.id}"
  location = var.location
}

# Minimal Burstable PostgreSQL Flexible Server with a public endpoint.
# - `B_Standard_B1ms` is the cheapest tier (~1 vCPU / 2 GiB) and is fine
#   for an introductory lab. Destroy it as soon as you are done.
# - `public_network_access_enabled = true` exposes a public endpoint that
#   is locked down to zero IPs until you add a firewall rule below.
# - We intentionally skip VNet injection / Private DNS to keep the
#   resource graph small. See `day4/chapter-5` for the full private setup.
resource "azurerm_postgresql_flexible_server" "pg" {
  name                          = "pg-${random_pet.id.id}"
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  version                       = "16"
  sku_name                      = "B_Standard_B1ms"
  storage_mb                    = 32768
  administrator_login           = var.admin_login
  administrator_password        = random_password.admin.result
  public_network_access_enabled = true

  # `zone` is intentionally not set: not every subscription has quota in
  # every availability zone, so letting Azure pick avoids
  # `AvailabilityZoneNotAvailable` errors on first-run subscriptions.
  lifecycle {
    ignore_changes = [zone, high_availability]
  }
}

# Optional firewall rule that opens port 5432 to a single IP. Only created
# when `client_ip` is provided. The rule's name has to be unique per server.
resource "azurerm_postgresql_flexible_server_firewall_rule" "client" {
  count            = var.client_ip == "" ? 0 : 1
  name             = "allow-client-ip"
  server_id        = azurerm_postgresql_flexible_server.pg.id
  start_ip_address = var.client_ip
  end_ip_address   = var.client_ip
}
