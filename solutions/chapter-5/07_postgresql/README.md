# 07 - PostgreSQL Flexible Server (basic)

A minimal Terraform example that creates an **Azure Database for PostgreSQL
Flexible Server**. This is the cheapest, simplest shape of the resource:

- 1 resource group
- 1 random suffix (so participants can run side-by-side without name clashes)
- 1 random administrator password
- 1 Burstable `B_Standard_B1ms` server with a public endpoint
- 1 optional firewall rule that opens port 5432 to your own IP

The full private-networking version (VNet injection + Private DNS zone +
DNS link) lives in [`day4/chapter-5`](../../../day4/chapter-5/README.md);
this folder is the friendly first step.

> [!IMPORTANT]
> Creating a Flexible Server typically takes **5–8 minutes**, and
> `terraform destroy` takes roughly the same time (the resource group
> deletion blocks on the database tearing down). Both commands will
> look like they are hanging — they aren't, the Azure control plane is
> just slow. Destroy as soon as you are done; the smallest tier still
> costs around **$13–15/month** if you leave it running.

---

## Prerequisites

- Azure CLI logged in: `az login`
- Subscription selected: `az account set --subscription <id>`
- The `Microsoft.DBforPostgreSQL` resource provider registered in your
  subscription (one-time, takes a few minutes):

  ```powershell
  az provider register --namespace Microsoft.DBforPostgreSQL --wait
  ```

---

## Step 1 — Initialise and apply (no firewall)

From this folder:

```powershell
terraform init
terraform apply -auto-approve
```

Expect output similar to:

```
azurerm_postgresql_flexible_server.pg: Still creating... [07m00s elapsed]
azurerm_postgresql_flexible_server.pg: Creation complete after 7m9s
...
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

postgres_admin_login    = "pgadmin"
postgres_admin_password = <sensitive>
postgres_fqdn           = "pg-xxx-yyy.postgres.database.azure.com"
postgres_server_name    = "pg-xxx-yyy"
resource_group_name     = "rg-pg-xxx-yyy"
```

At this point the server **exists** but no client can reach it — its
firewall is empty by default. That is fine for verifying the deployment:

```powershell
az postgres flexible-server show `
  --name (terraform output -raw postgres_server_name) `
  --resource-group (terraform output -raw resource_group_name) `
  -o table
```

---

## Step 2 — (Optional) Open the firewall for your own IP

Find your public IP and re-apply with the `client_ip` variable.

> [!NOTE]
> **Use a service that returns plain text.** `ifconfig.me` returns an
> HTML page when called from PowerShell (it sniffs the User-Agent), and
> Terraform will then reject the value because it isn't a valid IP. Use
> `https://api.ipify.org` instead, as shown below.

**PowerShell:**

```powershell
$myIp = (Invoke-RestMethod https://api.ipify.org).Trim()
"My IP: $myIp"
terraform apply -auto-approve -var "client_ip=$myIp"
```

**bash:**

```bash
MY_IP=$(curl -s https://api.ipify.org)
echo "My IP: $MY_IP"
terraform apply -auto-approve -var "client_ip=$MY_IP"
```

You can now connect with `psql`
(Windows: `winget install PostgreSQL.psql`,
macOS: `brew install libpq`,
Ubuntu/Debian: `sudo apt install postgresql-client`):

```powershell
$env:PGPASSWORD = terraform output -raw postgres_admin_password
psql "host=$(terraform output -raw postgres_fqdn) user=pgadmin dbname=postgres sslmode=require"
```

Inside `psql`, run a smoke test:

```sql
SELECT version();
```

Type `\q` to quit.

---

## Step 3 — Destroy

```powershell
terraform destroy -auto-approve
```

This deletes all 4 (or 3, if you skipped the firewall rule) resources.

---

## What you should take away

- `random_pet` + `random_password` give you globally-unique, beginner-safe
  names and credentials without checking secrets into Git.
- Flexible Server is **slow to provision**. Plan your demos accordingly.
- A `count = var.x == "" ? 0 : 1` pattern turns an entire resource into
  an opt-in. This is the simplest form of conditional resources in
  Terraform.
- Outputs marked `sensitive = true` are still stored in state and visible
  via `terraform output -raw <name>`, but they are not echoed to the
  apply log. Treat your `terraform.tfstate` file accordingly.
- A `validation {}` block on a variable lets you reject bad input
  **before** anything is sent to Azure (see `client_ip` in
  [`variables.tf`](variables.tf)).

---

## Troubleshooting

**`MissingSubscriptionRegistration` for `Microsoft.DBforPostgreSQL`**
Run the registration command in the Prerequisites section and wait a
few minutes before retrying `terraform apply`.

**`AvailabilityZoneNotAvailable: Availability zone '1' isn't available`**
Your subscription has no quota in that zone in the chosen region. This
config does **not** hardcode a zone for that reason — Azure picks one
automatically. If you ever pin `zone = "1"` manually and see this
error, either remove the line or try zone `2` / `3`.

**`The location 'westeurope' is not accepting creation of new ...
Flexible Server`**
The region temporarily has no capacity for the B-series. Override the
location:

```powershell
terraform apply -auto-approve -var "location=North Europe"
```

**`InvalidParameterValue: ... administrator_login ... reserved`**
`admin`, `azure_superuser`, `root`, etc. are not allowed. The default
`pgadmin` is safe; if you change it, avoid those keywords.

**`client_ip must be empty or a plain IPv4 address`**
Your IP-lookup command returned something other than a plain IPv4
string (most commonly an HTML page from `ifconfig.me`). Use
`https://api.ipify.org` as shown in Step 2.

**Apply succeeded but `psql` times out**
Your IP isn't in the firewall. Re-run Step 2 with the right `client_ip`,
or double-check that your network doesn't egress through a different
public address than `api.ipify.org` reports.

**`Error acquiring the state lock`**
A previous `terraform` process is still running (e.g. the long apply
hasn't finished). Wait for it to exit, then retry. As a last resort:
`terraform force-unlock <LOCK_ID>` — but only if you are sure no other
apply is in progress.

---

**[< back to Chapter 5 solutions](../README.md)**
