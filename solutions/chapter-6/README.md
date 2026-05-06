# Solutions Chapter 6 - Lab: Simple Terraform Deployment with GitHub

## Results

The results for Terraform should look like in [main.tf](main.tf).
The results for the GitHub Actions should look like in [chapter-6.yml](../../.github/workflows/chapter-6.yml).

### Configuration Details

- **Resource Group**: A resource group named `example-resources` located in `West Europe`.
- **Virtual Network**: A virtual network named `example-vnet` with an address space of `10.0.0.0/16`.
- **Subnet**: A subnet named `example-subnet` within the virtual network with an address prefix of `10.0.1.0/24`.
- **Network Interface**: A network interface named `example-nic` associated with the subnet.
- **Public IP Address**: A public IP address named `example-public-ip` associated with the network interface.

### Deployment Steps

1. Clone this repository to your local machine.
2. Open a terminal window and navigate to the root of the cloned repository.
3. Run `az login` to authenticate with your Azure account.
4. Run `terraform init` to initialize the Terraform configuration.
5. Run `terraform plan` to view the resources that will be created.
6. Run `terraform apply` to create the resources.
7. Run `terraform destroy` to delete the resources when you're done.
8. Run `az logout` to log out of your Azure account.

You successfully completed chapter 6. 🚀

## Continue

**[< back to Chapter](../../chapters/chapter-6/README.md) | [home](../../README.md)**
