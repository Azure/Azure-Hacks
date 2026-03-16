## Challenge 1: Connect to a Virtual Machine Using Azure Bastion

In this challenge, the focus is secure VM access through Azure Bastion.

<details>
<summary>✅ Quick Checklist</summary>
<br>

- Use the existing lab environment from Challenge 0.
- Connect to one existing VM through Bastion.
- Create one new VM in the same VNet.
- Connect to the new VM through Bastion.
- Keep VM management access without assigning VM public IPs.

</details>

> [!IMPORTANT]
> Use Bastion to connect to VMs without assigning a public IP address to the VM.

## Task 1: Connect to an Existing Lab VM via Bastion

In the lab environment from Challenge 0, Bastion and multiple VMs (Windows and Linux) are already deployed.

1. Go to the hub virtual network, for example `mh00-hub-germanywestcentral-vnet`.
2. In the left menu under **Settings**, select **Bastion**.
3. Select one existing VM from the lab (Windows or Linux), for example `mh00-linux`.
4. Set **Authentication Type** to `VM Password`.
5. Enter username `azadmin` and the password that was defined during the template deployment.
6. Open the session in a new browser tab.

<details close>
<summary>💡 If Bastion is not available</summary>
<br>

Use this guide to deploy Bastion:
- [Quickstart: Deploy Azure Bastion from the Azure portal](https://learn.microsoft.com/en-us/azure/bastion/quickstart-host-portal?tabs=default)

</details>

## Task 2: Create a New VM in the Same VNet and Connect via Bastion

Create a new virtual machine and connect to it through Bastion.

📘 **How-To Guides:**
- [Deploy Bastion as private-only](https://learn.microsoft.com/en-us/azure/bastion/private-only-deployment)
- [Working with NSG access and Azure Bastion](https://learn.microsoft.com/en-us/azure/bastion/bastion-nsg)

Use the following VM configuration:

| Setting | Value |
|---|---|
| Virtual Machine Name | vm1 |
| Region | Germany West Central |
| Availability Options | Availability Zone |
| Availability Zone | Zone 1 or Zone 2 |
| Image | Ubuntu 22.04 |
| Security Type | Standard |
| Size | Standard B2s |

Additional requirements:

- Use **Premium SSD (LRS)** for the disk.
- In **Networking**, use the same VNet as the existing lab environment.
- Do **not** assign a public IP address to the VM.

After deployment:

1. Open the newly created VM.
2. Go to **Connect** and run **Check access** (configure JIT if required).
3. Select **Go to Bastion**.
4. Set **Authentication Type** to `VM Password`.
5. Enter the username and password configured for this VM.
6. Open the session in a new browser tab.

Note: JIT rules are NSG rules added to your VM's NSG.

## Success Criteria 🎯

- You successfully connected to one existing lab VM via Bastion.
- You created a new VM in the same VNet.
- You connected to the new VM via Bastion.
- Both connections were performed without assigning public IP addresses to the VMs.

💡 **Learning Resources:**
- [What is Azure Bastion?](https://learn.microsoft.com/en-us/azure/bastion/bastion-overview)
- [Virtual network peering and Azure Bastion](https://learn.microsoft.com/en-us/azure/bastion/vnet-peering)
- [Configure Azure Bastion host scaling](https://learn.microsoft.com/en-us/azure/bastion/configure-host-scaling)

<details>
<summary>📎 Optional validation tip</summary>
<br>

After each Bastion login, run a quick command (for example `hostname`) to confirm you reached the expected VM.

</details>

**| [Next Challenge 2 - Build Resiliency with Load Balancer >](../challenge2/README.md)** |
**[< Previous Challenge 0 - Deploy the Multi-Region Lab](../challenge/README.md)**