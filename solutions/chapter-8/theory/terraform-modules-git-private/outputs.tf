output "landing-zone-rg" {
  description = "The created landing zone."
  value       = module.small_landing_zone.azurerm_resource_group.name
}
