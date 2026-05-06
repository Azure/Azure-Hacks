variable "resource_group_name" {

  description = "The name of the resource group in which the virtual network and virtual machine will be created."
  nullable    = false
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-]{0,68}[a-zA-Z0-9]$", var.resource_group_name))
    error_message = "The resource group name must start with a letter, can contain only alphanumeric characters or hyphens, cannot end with a hyphen, and must be 1-70 characters long."
  }
}

variable "location" {
  description = "The location in which the virtual network and virtual machine will be created."
  nullable    = false
  type        = string

  validation {
    condition     = contains(["East US", "West US", "Central US", "North Europe", "West Europe"], var.location)
    error_message = "The location must be one of the following: East US, West US, Central US, North Europe, or West Europe."
  }
}

# The public key to be used for SSH authentication to get access to the virtual machine.
variable "ssh_public_key" {

  description = "The public key to be used for SSH authentication."
  type        = string
  nullable    = false

}

variable "vnet_address_space" {
  description = "The address space for the virtual network."
  type        = string

  validation {
    condition     = can(regex("^.*/16$", var.vnet_address_space))
    error_message = "The vnet address space must use /16 as the size for the network."
  }
}

