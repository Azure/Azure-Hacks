variable "base_prefix" {
  default = "lab"
  description = "The common name prefix for all resources"
}

variable "location" {
  default = "swedencentral"
  description = "The location for all resources"
}

variable "vm_size" {
  default = "Standard_B2ats_v2"
  description = "The size of the jumphost VM to deploy"
}

variable "ssh_key" {
  # Update according to your public key
  # cat ~/.ssh/id_rsa.pub shows you the string to use
  default = ""
  description = "The SSH public key to use for the jumphost VM and AKS"
}