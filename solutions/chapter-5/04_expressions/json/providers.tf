# Configure the Azure Provider
provider "azurerm" {
  features {}
  alias = "default"
}

# Configure the GitHub Provider
provider "github" {
  token = "github_pat_"
  owner = "jeffreygroneberg"
  alias = "jeffreygroneberg"
}
