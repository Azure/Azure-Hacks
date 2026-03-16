## Challenge 2: Test Existing HA Setup and Build Your Own

This challenge has two parts:

1. Test the existing Windows web workload in the lab.
2. Build your own Linux workload across zones and attach it to the existing Sweden Central load balancer.

<details>
<summary>✅ Quick Checklist</summary>
<br>

- Validate the existing `web1`/`web2` app behind the load balancer.
- Deploy `vm1` and `vm2` in different availability zones.
- Add both Linux VMs to a load balancer backend pool.
- Verify failover by stopping one VM at a time.
- Optional: complete composite SLA and downtime calculation.

</details>

## Part 1: Test the Existing Web Application Behind the Load Balancer

In the lab, `web1` and `web2` (Windows VMs) are already running behind a load balancer in Germany West Central.

1. Go to load balancer `mh00-germanywestcentral-lb`.
2. In **Overview**, copy the **Frontend IP address** and open it in your browser.
3. Optionally, open the linked public IP resource `mh00-germanywestcentral-lb-pip` and test with DNS name.

Example DNS:

`mh00-germanywestcentral-lb-cfp5uykv.germanywestcentral.cloudapp.azure.com`

Now test failover behavior:

1. Stop `web1`, wait a few seconds, then refresh the page.
2. Start `web1`, stop `web2`, and refresh again.
3. Observe that the application remains available with low downtime.

## Part 2: Deploy Your Own Linux HA Setup in Sweden Central

Now implement your own resilient setup with Linux VMs.

Use these existing lab resources:

- Resource group: `mh00-target-swedencentral-rg`
- Load balancer: `mh00-swedencentral-lb`

📘 **How-To Guide:**
- [Create a Linux Virtual Machine in the Azure Portal](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-portal?tabs=ubuntu)

Deploy two VMs with the following configuration:

| Setting | Value |
|---|---|
| Virtual Machine Names | vm1 / vm2 |
| Region | swedencentral |
| Availability Options | Availability Zone |
| Availability Zones | Zone 1 / Zone 2 |
| Image | Ubuntu 22.04 |
| Security Type | Standard |
| Size | Standard B2s |

Additional VM requirements:

- Use **Premium SSD (LRS)** disks (no ultra disk compatibility).
- Use the same virtual network for both VMs.

<details close>
<summary>💡 Hint</summary>
<br>

For detailed instructions, please refer to:
- [Create a Linux Virtual Machine in the Azure Portal](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-portal?tabs=ubuntu)
- [AZ-104 Microsoft Azure Administrator Labs](https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/Instructions/Labs/LAB_08-Manage_Virtual_Machines.html)

</details>

Ensure you download the SSH key for each machine.

To connect to the virtual machines, use the SSH key and public IP address of each machine:

```bash
ssh -i ~/Downloads/myKey.pem azureuser@10.111.12.123
```

Install a web server on both VMs:

```bash
sudo apt-get -y update
sudo apt-get -y install nginx
```

## Attach the Linux VMs to a Load Balancer in Sweden Central

Recommended path: use the existing load balancer `mh00-swedencentral-lb`.

Optional path: participants can create a new load balancer if they prefer.

1. Open `mh00-swedencentral-lb` (or your new load balancer).
2. Open the backend pool and add both Linux VMs (`vm1` and `vm2`).
3. Ensure there is a health probe and load-balancing rule for HTTP (port 80).

If needed, update the NSG for each Linux VM to allow inbound HTTP (port 80):

| Configuration | Value |
|---|---|
| **Name** | `HTTP` |
| **Port** | 80 |
| **Priority** | 320 |
| **Protocol** | TCP |

## Validate Through the Sweden Central Load Balancer

1. Open the frontend IP or DNS of `mh00-swedencentral-lb` (or your new load balancer) in your browser.
2. Verify that the Linux web application is reachable.
3. Stop `vm1` and confirm traffic continues through `vm2`.
4. Start `vm1`, stop `vm2`, and validate again.

You should observe load balancer failover behavior in your own setup.

## Optional Final Challenge: Calculate Composite SLA and Downtime

Based on your architecture, calculate the theoretical composite SLA for:

- 2 VMs behind a Load Balancer
- Premium SSD managed disks

Use these training assumptions:

- VM availability: **99.9%**
- Load Balancer availability: **99.9%**

### Task

1. First calculate VM tier availability for two redundant VMs (parallel):

	`A(vm-tier) = 1 - (1 - 0.999)^2`

2. Then calculate composite SLA:

	`A(total) = A(load balancer) x A(vm-tier)`

3. Convert the resulting unavailability to expected downtime:

- per month (30 days)
- per year (365 days)

<details>
<summary>📌 Expected Result (for self-check)</summary>
<br>

- VM tier availability = **99.9999%**
- Composite SLA = **99.8999001%**
- Approximate downtime per month = **43.24 minutes**
- Approximate downtime per year = **526.13 minutes** (~8 hours 46 minutes)

</details>

> Optional comparison: the simplified series-only formula `0.999 x 0.999 = 99.8001%` is useful for basic practice, but it does not model VM redundancy correctly.

💡 **Learning Resources:**
- [Redundancy](https://learn.microsoft.com/en-us/azure/well-architected/reliability/redundancy)
- [What is Azure Load Balancer?](https://learn.microsoft.com/en-us/azure/load-balancer/load-balancer-overview)
- [What is Reliability?](https://learn.microsoft.com/en-us/azure/reliability/overview)
- [Design for Resilience](https://learn.microsoft.com/en-us/azure/well-architected/reliability/principles#design-for-resilience)

## Success Criteria 🎉

- 🎊 You tested the existing `web1`/`web2` lab application behind the Germany West Central load balancer.
- 🎊 You deployed two Linux VMs (`vm1` and `vm2`) in Sweden Central across Zone 1 and Zone 2.
- 🎊 You attached both VMs to a load balancer backend pool in Sweden Central (existing or new).
- 🎊 You validated application access and failover through the load balancer frontend.
- 🎊 You calculated the composite SLA and estimated expected downtime for the architecture.

<details>
<summary>📎 Optional validation tip</summary>
<br>

Set different landing page text on `vm1` and `vm2` (for example, "served by vm1" / "served by vm2") to observe backend switching more clearly.

</details>

**| [Next Chapter 2 - Azure AD: Entra ID >](../../../day2/chapter-2/README.md)** |
**[< Previous Challenge 1 - Connect with Azure Bastion](../challenge1/README.md)**
