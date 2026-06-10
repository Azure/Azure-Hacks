# Configure the Azure Provider.
# Credentials come from `az login` (the Azure CLI).
provider "azurerm" {
  features {}
}

# Configure the GitHub Provider.
# `token` and `owner` are intentionally NOT set here — the provider
# automatically reads them from the GITHUB_TOKEN and GITHUB_OWNER
# environment variables. This keeps the PAT out of source control.
# See the README for how to create a token and export the variables.
provider "github" {}
