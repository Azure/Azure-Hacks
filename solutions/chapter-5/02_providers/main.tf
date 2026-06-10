# Short random suffix so participants don't collide on resource group
# and repository names.
resource "random_pet" "id" {
  length    = 2
  separator = "-"
}

# Resource group in Azure
resource "azurerm_resource_group" "example_rg" {
  provider = azurerm.default
  name     = "rg-providers-${random_pet.id.id}"
  location = "West Europe"
}

# GitHub repository (same name as the resource group)
resource "github_repository" "example_repo" {
  provider    = github.demo
  name        = azurerm_resource_group.example_rg.name
  description = "Example repo managed by Terraform, same name as the Azure resource group."
  visibility  = "private"
  auto_init   = true
}

resource "github_repository_file" "readme" {
  provider            = github.demo
  repository          = github_repository.example_repo.name
  file                = "README.md"
  overwrite_on_create = true
  content             = "example content"
  branch              = "main"
}

