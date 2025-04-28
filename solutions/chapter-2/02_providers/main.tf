# Resource group in Azure
resource "azurerm_resource_group" "example_rg" {
  provider = azurerm.default
  name     = "exampleResourceGroup"
  location = "West Europe"
}

# GitHub repository
resource "github_repository" "example_repo" {
  provider    = github.jeffreygroneberg
  name        = azurerm_resource_group.example_rg.name
  description = "An example repository managed by Terraform with the same name as the Azure Resource Group"
  visibility  = "private"
  auto_init = true
}

resource "github_repository_file" "readme" {
  provider            = github.jeffreygroneberg
  repository          = github_repository.example_repo.name
  file                = "README.md"
  overwrite_on_create = true
  content             = "example content"
  branch              = "main"
  depends_on          = [github_repository.example_repo]
}