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
  # Update according to your own username
  default = "C:/Users/JOJOOSS/.ssh/id_rsa.pub"
  description = "The public SSH key to use for the jumphost VM and AKS"
}

variable "k8s_version" {
  default = "1.29.5"
  description = "The version of Kubernetes to deploy"
}

variable "aoai_model_name" {
  default = "gpt-35-turbo-16k"
  description = "The name of the OpenAI model to deploy"
}

variable "aoai_model_version" {
  default = "0613"
  description = "The version of the OpenAI model to deploy"
}