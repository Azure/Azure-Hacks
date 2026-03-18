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

variable "aoai_model_name" {
  description = "The name of the OpenAI model to deploy"
  type = string
}

variable "aoai_model_version" {
  description = "The version of the OpenAI model to deploy"
  type = string
}