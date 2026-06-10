# Default Azure provider — credentials come from `az login`.
provider "azurerm" {
  features {}
  alias = "default"
}

# GitHub provider — credentials come from environment variables
# (GITHUB_TOKEN and GITHUB_OWNER), so the PAT never lands in source
# control. See the README for how to export them.
provider "github" {
  alias = "demo"
}
