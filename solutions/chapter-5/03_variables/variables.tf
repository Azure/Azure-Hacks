variable "resource_group_name" {
  description = "Name fragment for the resource group (a prefix and random suffix are added)."
  type        = string
}

variable "resource_group_location" {
  description = "Azure region for the resource group."
  type        = string
}
