# Variables

## Overview

This Terraform module showcases the usage of variables, locals and outputs in Terraform. It sets up resource group by taking two variables as input and outputs the resource group name.
In addition to this it showcases the usage of tfvars files to provide the values for the variables.

## Prerequisites

- An Azure account
- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed on your local machine
- [Github Account](https://github.com) available

## Configuration Details

We will create resource groups, github repositories and readme files using Terraform. As a baseline we will use a variable to define the number of resources been created. 

## Deployment Steps

> [!CAUTION]
> Please follow the instructions and ALWAYS destroy your environment so that you can move on with a clean slate.

### Using no tfvars file

1. Run `az login` to authenticate with your Azure account.
2. Run `terraform init` to initialize the Terraform configuration.
3. Run `terraform plan` to view the resources that will be created.
4. Run `terraform apply` to create the resources.
5. Enter the values for the variables when prompted.
6. Run `terraform destroy` to delete the resources when you're done.

### Using a specific tfvars file

1. Run `az login` to authenticate with your Azure account.
2. Run `terraform init` to initialize the Terraform configuration.
3. Choose on of the provided tfvars files and reference it when running the `terraform plan` and `terraform apply` commands by using the `-var-file` parameter (eg `terraform apply -var-file=envs/europe.tfvars`).
4. Destroy the resources when you're done: `terraform destroy -var-file=envs/europe.tfvars`.

### Using the default tfvars file

1. Run `az login` to authenticate with your Azure account.
2. Run `terraform init` to initialize the Terraform configuration.
3. Copy one of the envs files to `terraform.tfvars` (eg `cp envs/europe.tfvars terraform.tfvars`).
4. Run `terraform plan` to view the resources that will be created.
5. Run `terraform apply` to create the resources.
6. Run `terraform destroy` to delete the resources when you're done.
7. Remove the `terraform.tfvars` file when you're done.

### Using environment variables for the variables

1. Run `az login` to authenticate with your Azure account.
2. Run `terraform init` to initialize the Terraform configuration.
3. Set the environment variables in your terminal `TF_VAR_RESOURCE_GROUP_NAME` and `TF_VAR_RESOURCE_GROUP_LOCATION` with the values you want to use: `export TF_VAR_RESOURCE_GROUP_NAME=exampleResourceGroup` and `export TF_VAR_RESOURCE_GROUP_LOCATION=westeurope`.
4. Run `terraform plan` to view the resources that will be created.
5. Run `terraform apply` to create the resources.
6. Run `terraform destroy` to delete the resources when you're done.





