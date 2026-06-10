output "resource_group_name" {
  description = "Name of the resource group that owns the server."
  value       = azurerm_resource_group.rg.name
}

output "postgres_server_name" {
  description = "Short name of the PostgreSQL Flexible Server."
  value       = azurerm_postgresql_flexible_server.pg.name
}

output "postgres_fqdn" {
  description = "Fully-qualified DNS name to connect to (port 5432)."
  value       = azurerm_postgresql_flexible_server.pg.fqdn
}

output "postgres_admin_login" {
  description = "Administrator login name."
  value       = azurerm_postgresql_flexible_server.pg.administrator_login
}

output "postgres_admin_password" {
  description = "Administrator password. Read with `terraform output -raw postgres_admin_password`."
  value       = random_password.admin.result
  sensitive   = true
}
