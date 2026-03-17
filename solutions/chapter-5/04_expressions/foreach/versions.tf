terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.1"
    }

    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }

  }
}
