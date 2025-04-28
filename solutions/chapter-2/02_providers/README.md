# Terraform Providers

## Overview

This Terraform configuration sets up basic Azure infrastructure with a a resource group and a github repository.
You need a PAT from your Github account to authenticate with the Github provider: https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token

The token needs the following permissions:
- Read and Write on your repositories 

Careful with this token. It is a secret and should be treated as such and not published or shared.

## Prerequisites

- An Azure account
- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed on your local machine

## Configuration Details

- **Resource Group**: A resource group named `exampleResourceGroup` located in `West Europe`.
- **Github Repository**: A github repository named the same like your resource group located in your github account.

> [!CAUTION] 
> The Github provider requires a Personal Access Token (PAT) to authenticate with Github. Please create a PAT and store it in a secure location. Do not share or publish the PAT. You also need to provide a organisation.

## Deployment Steps

1. Clone this repository to your local machine (if not already done). **Careful: forking the repository might be the better option**
2. Open a terminal window and navigate to the root of the cloned repository.
3. Run `az login` to authenticate with your Azure account.
4. Run `terraform init` to initialize the Terraform configuration.
5. Run `terraform plan` to view the resources that will be created.
6. Run `terraform apply` to create the resources.
7. Run `terraform destroy` to delete the resources when you're done.