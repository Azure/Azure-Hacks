# Chapter 8 - Terraform modularization (Modular Deployments)

## Goal

The goal of this lab is to reflect on the outcome of the previous lab and apply the knowledge to create a modularized deployment. Keep in mind that **there are many options while modularizing your Terraform deployment**.

## Actions

### 1. Reflect on the outcome of the previous lab

- Reflect on the outcome of previous Lab.
- Identify similarities and differences in the existing Terraform files.
- Identify resources that could be grouped together.

### 2. Prepare your Terraform project for modularization

- Create a folder `modules` in your `your-user-name-chapter-7` Terraform project from [chapter-7](../../chapter-7/README.md)
- Create a `variables.tf` and `outputs.tf` file in the root folder, if not already present.
- Build Terraform Modules where you think it makes sense. You can follow the refactoring that had been shown previously. ([sample](../../../solutions/chapter-8/theory/terraform-modules-local))
- Make sure that each module consists of the following files:
  - `variables.tf`
  - `main.tf`
  - `outputs.tf`
- Remember that each module will be one dedicated subfolder of your `modules` folder. A sample structure could look like the following:
```bash
├── main.tf # root main.tf
├── variables.tf # root variables.tf
├── modules # modules folder
│   ├── network # network module
│   │   ├── main.tf # network module main.tf
│   │   ├── variables.tf # network module variables.tf
│   │   └── outputs.tf # network module outputs.tf
│   ├── db # database module
│   │   ├── main.tf # db module main.tf
│   │   ├── variables.tf # db module variables.tf
│   │   └── outputs.tf # db module outputs.tf
│   ├── compute # compute module
│   │   ├── main.tf # compute module main.tf
│   │   ├── variables.tf # compute module variables.tf
│   │   └── outputs.tf # compute module outputs.tf
│   ├── k8s # k8s module
│   │   ├── main.tf # k8s module main.tf
│   │   ├── variables.tf # k8s module variables.tf
│   │   └── outputs.tf # k8s module outputs.tf
│   ├── ai # ai module
│   │   ├── main.tf # ai module main.tf
│   │   ├── variables.tf # ai module variables.tf
│   │   └── outputs.tf # ai module outputs.tf
```
- You can now either build your modules based on the sample structure above or create your own structure.
- Each module should be referenced on a local paths within root `main.tf` (`source = "./modules/your-module-name"`).
- Keep also in mind that your newly created modules have the required outputs defined in `outputs.tf` to be used in the root `main.tf`.

### 3. Verify the modularized deployment locally

- Verify that Terraform execution still works locally on your DevBox. Make sure that the basic Terraform command succeed. (`terraform plan`, `terraform apply`, `terraform destroy`)

> [!CAUTION]
> Feel free to use the [provided solution](../../../solutions/chapter-8/labs/) as a reference. However, make sure to understand the concept of Terraform modules and apply it to your own deployment.

### 4. Verify the GitHub Actions workflow

- Adapt the existing GitHub Actions workflow accordingly (if necessary) to work with the new modularized deployment.
- Commit your changes to the repository.
- Verify that the GitHub Actions workflow still works.
- Make sure that all resources are still created as expected.

### 5. Finally

- Remove all your resources from Azure.

## Success criteria

- You have successfully modularized your existing Terraform deployment
- You understand the concept of Terraform modules
- You have successfully adapted your GitHub Actions to work with the new modularized deployment
- You have successfully deployed the modularized deployment

## Learning resources

- [Azure Verified Modules](https://azure.github.io/Azure-Verified-Modules/indexes/terraform/tf-resource-modules/#published-modules-----)
- [Azure IaC Best Practices](https://azure.github.io/Azure-Verified-Modules/specs/shared/)
- [Terraform Best Practices](https://azure.github.io/Azure-Verified-Modules/specs/terraform/)

## Continue

**[< back](../README.md) | [home](../../../README.md) | [next >](../../chapter-9/README.md) | [solutions](../../../solutions/chapter-8/README.md)**
