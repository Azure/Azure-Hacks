# Solutions Chapter 8 - Terraform modularization (Modular Deployments)

## Overview

The goal of this chapter is to showcase the modularization of Terraform code. This is a common practice to make the code more readable, maintainable, and reusable.

What you will find in this folder are multiple solutions to showcase how to create Terraform modules:

- `terraform-modules-local` - This solution showcases how to create a local module in Terraform.
- `terraform-modules-git-private` - This solution showcases how to create a remote module in Terraform hosted on Github.

In addition to this there is also an example of how to deploy a small Verified Azure Module in folder `azure-verified-modules`.

## Deploy the solutions

### Terraform modules local

1. Navigate to the `terraform-modules-local` folder.
2. Run `terraform init` to initialize the Terraform configuration.
3. Run `terraform plan` to see the execution plan.
4. Run `terraform apply` to deploy the resources.
5. Run `terraform destroy` to remove the resources.
6. Careful due to the NIC resource, it might not be deleted due to the dependency on the VM. **So rerun the destroy command if needed.**

### Terraform modules git private

1. Navigate to the `terraform-modules-git-private` folder.
2. You need to have a Github access token to access the private repository. You can create one by following the instructions [here](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token).
3. Replace the `github_token` value in the `main.tf` file with your Github access token in the provider.
4. Run `terraform init` to initialize the Terraform configuration.
5. Run `terraform plan` to see the execution plan.
6. Run `terraform apply` to deploy the resources.
7. Run `terraform destroy` to remove the resources.
8. Careful due to the NIC resource, it might not be deleted due to the dependency on the VM. **So rerun the destroy command if needed.**

### Azure Verified Modules

1. Navigate to the `azure-verified-modules` folder.
2. Run `terraform init` to initialize the Terraform configuration.
3. Run `terraform plan` to see the execution plan.
4. Run `terraform apply` to deploy the resources.
5. Run `terraform destroy` to remove the resources.

## Learning resources

- Terraform alternatives for private registry: https://medium.com/@DiggerHQ/private-module-registries-for-terraform-a-list-of-available-tooling-options-3e2f798d41b5

## Continue

**[< back to Chapter](../../chapters/chapter-8/README.md) | [home](../../README.md)**
