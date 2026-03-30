# Chapter 5 - Bonus Lab: PostgreSQL with Terraform

> This lab extends your Terraform project with Azure Database for PostgreSQL. It teaches private networking concepts (Private DNS zones, VNet integration) alongside a managed database service.

---

## Prerequisites

Before starting this lab, make sure you have:
- Completed **Chapter 3** and **Chapter 4** (resource group, VNet, ACR, and AKS exist in your Terraform project)
- Your Terraform project from Chapter 4 (you’ll add PostgreSQL resources to it)
- (Optional) The `go-probe` test application running via `kubectl port-forward` on http://localhost:8080 for in-app verification

> **⏱️ Time estimate:** The PostgreSQL Flexible Server creation takes **~4–5 minutes**. The full lab (subnet + DNS + link + server) totals **~8–12 minutes** of Terraform apply time.

---

# 6 - PostgreSQL

Next, you will deploy a managed PostgreSQL server. Unlike the ACR, which you have exposed publicly, you will restrict network access to this server to the virtual network using a private DNS zone and VNet injection.

## 6a - Subnet for PostgreSQL

If your virtual network does not yet have a `postgres` subnet, you need to create one first. This subnet must have a **delegation** for `Microsoft.DBforPostgreSQL/flexibleServers`.

### Objectives
- Create a subnet named `postgres` in your existing virtual network.
- Use an address prefix that does not overlap with your other subnets (e.g., `10.20.2.0/24`).
- Add a **service delegation** for `Microsoft.DBforPostgreSQL/flexibleServers`.
- Add the service endpoint `Microsoft.Storage`.

### Terraform Hint

```hcl
resource "azurerm_subnet" "postgres" {
  name                 = "postgres"
  resource_group_name  = azurerm_resource_group.lab.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.20.2.0/24"]
  service_endpoints    = ["Microsoft.Storage"]

  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}
```

> **Important:** The delegation is required — without it, the PostgreSQL Flexible Server deployment will fail with a `SubnetMissingServiceDelegation` error.

---

## 6b - Private DNS Zone

Before you can deploy the database server, you must deploy a Private DNS Zone to allow applications to resolve the PostgreSQL FQDN to its private IP address.

### Objectives
- Create a private DNS zone.
- Place the DNS zone in your existing resource group. Unlike the other resources you have created so far, a DNS zone is a **global** resource and hence not placed in a specific region.
- Use the following name for the DNS zone: `randomname.postgres.database.azure.com`, where `randomname` is the same random prefix you have been using for the other resources, e.g. `lab-3945.postgres.database.azure.com`.

### Terraform Hint

```hcl
resource "azurerm_private_dns_zone" "private_dns" {
  name                = "${local.name_prefix}.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.lab.name
}
```

### Success Criteria
- You have created a private DNS zone with the desired name.

---

## 6c - Network Link

So far, the DNS zone just exists, but if you tried to use it through tools such as `nslookup` or `dig`, you will not find any resource records for this zone. To use the DNS zone with your virtual network, you have to create a **network link** that associates the DNS zone with the virtual network.

### Objectives
- Create a private DNS zone virtual network link.
- Place the network link in your existing resource group.
- The link must refer to your previously created private DNS zone.
- The linked network must be your virtual network.
- Randomize the network link's name the same way you have randomized your resource group's name.

### Terraform Hint

```hcl
resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_vnet_link" {
  name                  = "${local.name_prefix}-vnet-link"
  private_dns_zone_name = azurerm_private_dns_zone.private_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  resource_group_name   = azurerm_resource_group.lab.name
}
```

### Success Criteria
- You have linked the private DNS zone to your virtual network.
- You can use the test application to query the DNS zone.

#### Verification
On your test app's home page at http://localhost:8080, click the **DNS** link.

Enter the following values and click **Test**:

- **Type:** `SOA`
- **Value:** Fully qualified domain name of your PostgreSQL private DNS zone, e.g. `lab-3945.postgres.database.azure.com.` (note the trailing `.`!)

The app should resolve the start of authority resource record.

---

## 6d - Azure Database for PostgreSQL Flexible Server

With DNS working properly, you can now create an Azure Database for PostgreSQL Flexible Server.

### Objectives
- Create an Azure Database for PostgreSQL Flexible Server.
- Place the server in your existing resource group in Sweden Central.
- Use PostgreSQL version **16** (or 15 if you prefer).
- Use `B_Standard_B1ms` as SKU.
- Deploy it to availability zone **1**.
- Set its storage size to **32768 MB** (32 GB).
- Enable storage auto grow.
- Set backup retention to **7** days.
- Disable public network access.
- Use `flexadmin` as PostgreSQL administrator login name.
- Use a **random secure password** for the PostgreSQL administrator login.
- Inject the server into the `postgres` subnet.
- Associate it with your private DNS zone.

> **Tip:** Use the `random_password` resource to generate a secure password:
> ```hcl
> resource "random_password" "pg_password" {
>   length           = 20
>   special          = true
>   min_upper        = 1
>   min_lower        = 1
>   min_numeric      = 1
>   min_special      = 1
>   override_special = "_-"
> }
> ```
> Then add an output block to retrieve the password later:
> ```hcl
> output "pg_password" {
>   value     = random_password.pg_password.result
>   sensitive = true
> }
> ```

> **Important:** The PostgreSQL Flexible Server **depends on** the DNS zone VNet link being created first. Add a `depends_on` block to ensure Terraform creates them in the right order:
> ```hcl
> depends_on = [azurerm_private_dns_zone_virtual_network_link.private_dns_vnet_link]
> ```

### Terraform Hint

```hcl
resource "azurerm_postgresql_flexible_server" "postgres" {
  name                          = "${local.name_prefix}-postgres"
  resource_group_name           = azurerm_resource_group.lab.name
  location                      = azurerm_resource_group.lab.location
  version                       = "16"
  sku_name                      = "B_Standard_B1ms"
  zone                          = "1"
  storage_mb                    = 32768
  auto_grow_enabled             = true
  backup_retention_days         = 7
  administrator_login           = "flexadmin"
  administrator_password        = random_password.pg_password.result
  public_network_access_enabled = false
  delegated_subnet_id           = azurerm_subnet.postgres.id
  private_dns_zone_id           = azurerm_private_dns_zone.private_dns.id

  depends_on = [azurerm_private_dns_zone_virtual_network_link.private_dns_vnet_link]
}
```

### Success Criteria
- You have created an Azure Database for PostgreSQL Flexible Server.
- You can connect to the server from the test application.

#### Verification

**Option A — Via the go-probe test app** (if running):

On your test app’s home page at http://localhost:8080, click the **PostgreSQL** link.

Enter the following values and click **Test**:

- **FQDN:** Fully qualified domain name of your PostgreSQL Flexible Server (find it in the Azure portal or via `terraform output`)
- **Login:** `flexadmin`
- **Password:** The password you set for your server. Retrieve it with:
  ```powershell
  terraform output -raw pg_password
  ```
- **Use TLS:** Enabled

**Option B — Via the Azure Portal:**

1. Open the [Azure Portal](https://portal.azure.com)
2. Navigate to your resource group
3. Click on your PostgreSQL Flexible Server
4. Check that the **Status** is `Ready`
5. In the **Overview** blade, verify the **Server name** (FQDN) is shown
6. Under **Settings > Networking**, verify the server is connected to your `postgres` subnet and private DNS zone

> **Note:** TLS is enforced by Azure Database for PostgreSQL Flexible Server by default. Do not disable it!

---

## Common Mistakes

| Mistake | Symptom | Fix |
|---------|---------|-----|
| Missing subnet delegation | `SubnetMissingServiceDelegation` error | Add `delegation` block for `Microsoft.DBforPostgreSQL/flexibleServers` |
| Missing `depends_on` | DNS zone link not ready → server creation fails | Add `depends_on = [azurerm_private_dns_zone_virtual_network_link....]` |
| Overlapping subnet address space | `SubnetAddressSpaceOverlap` error | Use a non-overlapping CIDR (e.g., `10.20.2.0/24`) |
| Wrong SKU format | `InvalidParameterValue` error | Use `B_Standard_B1ms` (not just `Standard_B1ms`) |
| Password too simple | `InvalidParameterValue` for password | Use `random_password` with mixed case, numbers, and special chars |
| Missing `random` provider | `Could not retrieve the list of available versions` | Add `hashicorp/random` to your `required_providers` block |

---

## Learning resources
- [azurerm_postgresql_flexible_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server)
- [azurerm_private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone)
- [azurerm_private_dns_zone_virtual_network_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link)
- [Deploy a PostgreSQL Flexible Server Database using Terraform](https://learn.microsoft.com/en-us/azure/developer/terraform/deploy-postgresql-flexible-server-database?tabs=azure-cli)

## Sample solution
See [here](../../solutions/chapter-7/ch-06/).

---

## Stuck? Deploy the solution and continue

If you can't get your Terraform code to work, you can deploy the provided solution and move on:

```powershell
# Replace <repo> with the path where you cloned the Cloud-Academy repo
Copy-Item -Force "<repo>\AzureBaseTraining\solutions\chapter-7\ch-06\*" C:\lab-solution\
cd C:\lab-solution
```

> **Important:** Copying these files will **overwrite** your `variables.tf`. You must re-set the `ssh_key` variable to your SSH public key (see Chapter 3 for instructions).

```powershell
terraform init
terraform apply    # ~5-10 min for PostgreSQL
```

Then continue with [Chapter 6](../chapter-6/README.md).

---

**[< back](../chapter-4/README.md) | [next: Azure OpenAI Lab >](../chapter-6/README.md)**
