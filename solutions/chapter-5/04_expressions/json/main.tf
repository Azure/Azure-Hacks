# Read the JSON file
data "local_file" "resources" {
  filename = "${path.module}/conf/config.json"
}

locals {
  resources = jsondecode(data.local_file.resources.content).resources
}

# Resource groups in Azure
resource "azurerm_resource_group" "example_rg" {
  for_each = { for idx, resource in local.resources : idx => resource }
  provider = azurerm.default

  name     = each.value.rg_name
  location = each.value.location
}

# GitHub repositories
resource "github_repository" "example_repo" {
  for_each = { for idx, resource in local.resources : idx => resource }
  provider    = github.jeffreygroneberg

  name        = each.value.repo_name
  description = each.value.repo_desc
  visibility  = "private"
  auto_init   = true
}

# README files in GitHub repositories
resource "github_repository_file" "readme" {
  for_each = { for idx, resource in local.resources : idx => resource }
  provider            = github.jeffreygroneberg

  repository          = github_repository.example_repo[each.key].name
  file                = "README.md"
  overwrite_on_create = true
  content             = each.value.repo_content
  branch              = "main"
  depends_on          = [github_repository.example_repo]
}
