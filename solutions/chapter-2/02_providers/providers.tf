# Configure the Azure Provider
provider "azurerm" {
  features {}
  alias = "default"
}

# Configure the GitHub Provider
provider "github" {

  # Personal Access Token for GitHub. You can get this from your GitHub account settings. 
  # Make sure to keep this secure and not share it with anyone.    
  token = "github_pat_///"

  owner = "jeffreygroneberg"
  # Owner of the GitHub repository
  alias = "jeffreygroneberg"
  
}