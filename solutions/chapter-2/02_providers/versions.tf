# Remark for questions!

# Example Scenario Without required_providers:
# Terraform Initialization: When you run terraform init, Terraform attempts to download the latest versions of the providers if the versions are not specified. 
# This might not always be what you want, especially in production environments where stability and predictability are crucial.
# Potential Errors: If you're using a specific feature or syntax that is only available in certain versions of a provider, not 
# specifying the version can lead to errors if Terraform downloads a version that doesn't support what you're trying to do.

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