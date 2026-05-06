variable "name_prefix" {
  description = "The prefix for the name of the resources"
  type        = string
}

variable "location" {
  description = "The location of the virtual machine"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "ssh_key" {
  description = "The path to the SSH public key"
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
}
