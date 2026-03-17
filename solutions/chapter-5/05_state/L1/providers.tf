terraform {

  backend "azurerm" {
    resource_group_name  = "valid-sheepdog"
    storage_account_name = "3vemnyov5hsfmuoy3oz9ur0y"
    container_name       = "real-wren"
    key                  = "terraform.tfstate"
  }

}

provider "azurerm" {
  features {}
}

provider "random" {}
