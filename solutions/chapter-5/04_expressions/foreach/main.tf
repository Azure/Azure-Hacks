
# Create a list of indexes
locals {
  indexes = [for i in range(var.resource_count) : i]
}

# Resource groups in Azure
resource "azurerm_resource_group" "example_rg" {
  for_each = { for idx in local.indexes : idx => idx }
  provider = azurerm.default

  name     = "exampleResourceGroup-${each.key}"
  location = "West Europe"
}

# GitHub repositories
resource "github_repository" "example_repo" {
  for_each = { for idx in local.indexes : idx => idx }
  provider    = github.jeffreygroneberg

  name        = "exampleRepo-${each.key}"
  description = "Repository for exampleResourceGroup-${each.key}"
  visibility  = "private"
  auto_init   = true
}

# README files in GitHub repositories
resource "github_repository_file" "readme" {
  for_each = { for idx in local.indexes : idx => idx }
  provider            = github.jeffreygroneberg

  repository          = github_repository.example_repo[each.key].name
  file                = "README.md"
  overwrite_on_create = true
  content             = "Content for exampleRepo-${each.key}"
  branch              = "main"
  depends_on          = [github_repository.example_repo]
}
