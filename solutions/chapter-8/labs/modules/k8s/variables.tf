variable "name_prefix" {
  description = "The common name prefix for all resources"
  type        = string
}

variable "location" {
  description = "The location of the Kubernetes cluster"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "k8s_version" {
  default = "1.29.5"
  description = "The version of Kubernetes to deploy"
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "ssh_key" {
  description = "The path to the SSH public key"
  type        = string
}