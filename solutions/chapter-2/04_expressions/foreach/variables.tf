# Define the number of resources
variable "resource_count" {
  description = "Number of resource groups and repositories to create"
  type        = number
  default     = 6
}