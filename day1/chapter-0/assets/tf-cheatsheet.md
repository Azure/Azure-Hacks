# Terraform Cheatsheet 🚀

| Command | Description |
|---------|-------------|
| `terraform init` | 🌱 Initialize a Terraform working directory. |
| `terraform plan` | 📝 Show changes required by the current configuration. |
| `terraform apply` | ✅ Apply the changes required to reach the desired state of the configuration. |
| `terraform destroy` | 🔥 Destroy the Terraform-managed infrastructure. |
| `terraform fmt` | 🎨 Rewrites config files to canonical format and style. |
| `terraform validate` | ✔️ Validates the Terraform configuration files for syntax. |
| `terraform output` | 📤 Show output values from your deployment. |
| `terraform refresh` | 🔄 Update local state file against real resources. |
| `terraform import` | 📥 Import existing infrastructure into Terraform. |
| `terraform state` | 📦 Advanced state management commands. |
| `terraform graph` | 📊 Create a visual graph of Terraform resources. |
| `terraform taint` | 🚧 Mark a resource instance as not fully functional. |
| `terraform untaint` | 🚧 Remove the 'tainted' state from a resource instance. |
| `terraform workspace` | 🏗 Workspace management commands. |
| `terraform providers` | 📦 Show the providers required for this configuration. |
| `terraform console` | 🧮 Interactive console for evaluating expressions. |
| `terraform login` | 🔐 Obtain and save credentials for a remote host. |
| `terraform logout` | 🔓 Remove locally-stored credentials for a remote host. |
## Upgrade providers
    
```bash
terraform init -upgrade
```


