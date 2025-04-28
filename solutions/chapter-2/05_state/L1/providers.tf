terraform {

  backend "azurerm" {
    resource_group_name  = "alert-peacock"
    storage_account_name = "5j9347mv0h2efps7ylz2igg9"
    container_name       = "live-tick"
    key                  = "terraform.tfstate"
    subscription_id = "85c265c4-ebb5-49b1-b0a3-eb334a0a1a80"
  }

}

provider "azurerm" {
  features {}
  subscription_id = "85c265c4-ebb5-49b1-b0a3-eb334a0a1a80"
}

provider "random" {}
