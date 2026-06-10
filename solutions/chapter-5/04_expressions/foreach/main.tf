
# Create a list of indexes
locals {
  indexes = [for i in range(var.resource_count) : i]
}

# Resource groups in Azure
resource "azurerm_resource_group" "example_rg" {
  for_each = { for idx in local.indexes : idx => idx }

  name     = "exampleResourceGroup-${each.key}"
  location = "West Europe"
}

# GitHub repositories
resource "github_repository" "example_repo" {
  for_each = { for idx in local.indexes : idx => idx }

  name        = "exampleRepo-${each.key}"
  description = "Repository for exampleResourceGroup-${each.key}"
  visibility  = "private"
  auto_init   = true
}

# README files in GitHub repositories.
# The reference to `github_repository.example_repo[each.key].name`
# already creates an implicit dependency on the repo, so no explicit
# depends_on is needed.
resource "github_repository_file" "readme" {
  for_each = { for idx in local.indexes : idx => idx }

  repository          = github_repository.example_repo[each.key].name
  file                = "README.md"
  overwrite_on_create = true
  content             = "Content for exampleRepo-${each.key}"
  branch              = "main"
}
