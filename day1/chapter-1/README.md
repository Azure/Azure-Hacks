# Chapter 1 - Theory & Lab: VNet, VMs and Azure Portal

## Goal 🎯

This chapter is all about learning about Virtual Networks, Virtual Machines, and Azure Portal. You will learn how to create and manage Virtual Networks, Virtual Machines, and other resources in Azure:

- Introduction into Azure Portal
- Create and explain a VNET
- Create and explain a VM with Disk(s) and Public IP & Bastion, NSG (SSH Keys, Credential)

## Theory 📘

> [!CAUTION]
> For all the following topics there are slides available for the instructor:
> - [Azure Virtual Network](https://microsofteur-my.sharepoint.com/:p:/g/personal/joergjo_microsoft_com/EVHMQ0ucXChAlIAftPJ2jswB_GXWEqCzaaFbCGpXLz4Ynw?e=w3zw8O)
> - [Azure Virtual Machine](https://microsofteur-my.sharepoint.com/:p:/g/personal/joergjo_microsoft_com/ET7XuWLkqWJMsWDTlUi0HzIBssxAZFGEq9dtAgqkh9nTuA?e=ImXb7P)

### Virtual Network (VNet)

A Virtual Network (VNet) is a representation of your own network in the cloud. It is a logical isolation of the Azure cloud dedicated to your subscription. You can securely connect Azure resources to each other with VNets, extend your on-premises network to Azure, and filter outbound internet traffic.

**Key capabilities:**
- **Isolation & segmentation** — Create multiple isolated VNets using private IP address ranges (RFC 1918)
- **Internet communication** — All resources in a VNet can communicate outbound to the internet by default
- **Azure resource communication** — Resources within a VNet communicate securely with each other
- **On-premises connectivity** — Connect to on-prem via VPN Gateway, ExpressRoute, or Point-to-Site VPN
- **Traffic filtering** — Filter traffic using NSGs and Network Virtual Appliances
- **Traffic routing** — Azure routes traffic between subnets, VNets, and on-prem networks by default; customizable via route tables or BGP

**Example: Typical VNet layout for a web application**
```
+------------------------------------------------------+
| VNet: 10.0.0.0/16                                    |
|                                                      |
| +--------------------+  +-------------------------+  |
| | Frontend Subnet    |  | Backend Subnet          |  |
| | 10.0.1.0/24        |  | 10.0.2.0/24             |  |
| |                    |  |                         |  |
| | Web VMs + LB       |  | App VMs + Database      |  |
| | (Public IP / NSG)  |  | (Private only / NSG)    |  |
| +--------------------+  +-------------------------+  |
|                                                      |
| +--------------------+                               |
| | AzureBastionSubnet |                               |
| | 10.0.3.0/24        |                               |
| | (Bastion Host)     |                               |
| +--------------------+                               |
+------------------------------------------------------+
```

> 📖 [Learn more: What is Azure Virtual Network?](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview)

#### Public IP Address

A public IP address is a globally unique IP address that is reachable from the internet. You can associate a public IP address with a VM to enable communication with the internet. Azure provides dynamic and static public IP addresses.

Azure offers two SKUs for public IPs:

| Feature | Basic | Standard |
|---|---|---|
| Allocation | Dynamic or Static | Static only |
| Availability Zones | Not supported | Zone-redundant |
| Security | Open by default | Secure by default (inbound closed) |

> 📖 [Learn more: Public IP addresses in Azure](https://learn.microsoft.com/en-us/azure/virtual-network/ip-services/public-ip-addresses)

#### Bastion

Azure Bastion is a fully managed PaaS service that provides secure and seamless RDP and SSH access to your VMs directly through the Azure Portal. Azure Bastion is provisioned directly in your VNet and supports all VMs in your VNet using SSL without any exposure through public IP addresses.

![Bastion Architecture](https://learn.microsoft.com/en-us/azure/bastion/media/bastion-overview/architecture.png)

> 📖 [Learn more: What is Azure Bastion?](https://learn.microsoft.com/en-us/azure/bastion/bastion-overview)

#### Network Security Group (NSG)

A Network Security Group (NSG) contains a list of security rules that allow or deny inbound or outbound network traffic to resources connected to an Azure Virtual Network. NSGs can be associated with subnets, individual VMs, or both. NSGs are used to filter network traffic to and from Azure resources in an Azure Virtual Network.

![NSG Traffic Flow](https://learn.microsoft.com/en-us/azure/virtual-network/media/network-security-group-how-it-works/network-security-group-interaction.png)

> 📖 [Learn more: Network security groups](https://learn.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview)

### Virtual Machine (VM)

A Virtual Machine (VM) is a software computer that, like a physical computer, runs an operating system and applications. The VM consists of several components, such as disks, network interfaces, and extensions. You can create and manage VMs in the Azure Portal.

**Components of an Azure VM:**
```
┌─────────────────────────────────────────────┐
│  Azure Virtual Machine                      │
│                                             │
│  ┌───────────┐  ┌────────────────────────┐  │
│  │  OS Disk  │  │  Data Disk(s)          │  │
│  │ (Required)│  │  (Optional, up to 64)  │  │
│  └───────────┘  └────────────────────────┘  │
│                                             │
│  ┌───────────────────────────────────────┐  │
│  │  Network Interface (NIC)              │  │
│  │  ├─ Private IP (always)               │  │
│  │  ├─ Public IP (optional)              │  │
│  │  └─ NSG (optional, recommended)       │  │
│  └───────────────────────────────────────┘  │
│                                             │
│  ┌───────────────────────────────────────┐  │
│  │  Extensions (optional)                │  │
│  │  e.g. Custom Script, Monitoring Agent │  │
│  └───────────────────────────────────────┘  │
└─────────────────────────────────────────────┘
```

**Common VM size families:**

| Series | Optimized for | Example use case |
|---|---|---|
| **B** | Burstable | Dev/test, small databases |
| **D** | General purpose | Enterprise apps, mid-tier databases |
| **E** | Memory | In-memory analytics, large databases |
| **F** | Compute | Batch processing, gaming servers |
| **N** | GPU | ML training, rendering, HPC |
| **L** | Storage | Big data, NoSQL databases |

> 📖 [Learn more: Azure Virtual Machines overview](https://learn.microsoft.com/en-us/azure/virtual-machines/overview)  
> 📖 [Learn more: Azure VM sizes](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/overview)

#### Disk

A disk is a virtual hard drive that stores the operating system, applications, and data. Azure provides different types of disks, such as managed disks, unmanaged disks, and shared disks. Managed disks are the recommended disk storage option for VMs.

| Disk Type | Use Case | Max IOPS |
|---|---|---|
| Standard HDD | Dev/test, backups | 500 |
| Standard SSD | Web servers, light workloads | 6,000 |
| Premium SSD | Production, IO-intensive | 20,000 |
| Premium SSD v2 | High-performance databases | 80,000 |
| Ultra Disk | SAP HANA, top-tier databases | 400,000 |

> 📖 [Learn more: Azure managed disk types](https://learn.microsoft.com/en-us/azure/virtual-machines/disks-types)

#### Virtual Machine Scale Sets

Virtual Machine Scale Sets let you create and manage a group of identical, load-balanced VMs. The number of VM instances can automatically increase or decrease in response to demand or a defined schedule. Scale sets provide high availability to your applications, and allow you to centrally manage, configure, and update a large number of VMs.

**How autoscaling works:**
```
  Low demand           Normal             High demand
 ┌────┐              ┌────┐ ┌────┐       ┌────┐ ┌────┐ ┌────┐ ┌────┐
 │ VM │              │ VM │ │ VM │       │ VM │ │ VM │ │ VM │ │ VM │
 └────┘              └────┘ └────┘       └────┘ └────┘ └────┘ └────┘
 1 instance     ◄──  2 instances    ──►   4 instances
                    Scale in/out based on CPU, memory,
                    schedule, or custom metrics
```

**Key benefits:**
- Supports up to **1,000 VM instances** (standard images)
- Automatic OS image updates and rolling upgrades
- Integrates with **Azure Load Balancer** (L4) and **Application Gateway** (L7)
- Distributes VMs across **Availability Zones** for high availability
- No extra cost — you only pay for the VMs, storage, and networking used

> 📖 [Learn more: What are Virtual Machine Scale Sets?](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/overview)

## Day 1 Module Flow

This chapter is structured as a practical learning module. Start with the theory section above, then continue with the hands-on sequence below.

<details>
<summary>✅ Quick Start Checklist</summary>
<br>

- Open [Challenge 0](./challenge/README.md) and review prerequisites.
- Keep Azure Portal open in a separate tab.
- Track your resource names and regions as you go.
- Continue in order: Challenge 0 → Challenge 1 → Challenge 2.

</details>

## Recommended Learning Order

1. Cover Azure fundamentals and VM basics.
2. Introduce networking topics: VNet, NSG, Bastion, Load Balancer, and DNS.
3. Deploy the shared lab environment early so you can explore real resources during theory.
4. Run Challenge 1 and Challenge 2 in order.
5. Use MS Learn labs as reinforcement after the custom challenges.

## Lab Deployment and Exploration

> [!CAUTION]
> Day 1 does **not** use Terraform.
> For this module, deploy and explore the environment using Azure Portal and ARM template steps from **[Challenge 0](./challenge/README.md)**.
> Terraform is introduced in Day 2.

## Challenge 0: Deploy and Explore the Multi-Region Lab

Deploy infrastructure across two Azure regions using the ARM template. This creates the baseline environment used in Challenge 1 and Challenge 2.

Includes VNets with peering, VMs, Azure Bastion, Load Balancers, Recovery Services Vaults, and Traffic Manager.

**[➡️ Go to Challenge 0](./challenge/README.md)**

## Challenge 1: Connect with Azure Bastion

Use the already deployed lab environment and focus on secure VM access.

1. Connect to an existing VM (Windows or Linux) through Bastion.
2. Create a new VM in the same VNet and connect via Bastion.

Goal: VM access without exposing management through VM public IP addresses.

**[➡️ Go to Challenge 1](./challenge1/README.md)**

## Challenge 2: Build Resiliency with Load Balancer

Build on the same lab context:

1. Test the existing web application behind the load balancer.
2. Deploy two Linux VMs across two availability zones.
3. Add them to a load balancer backend pool (existing or new).
4. Validate failover behavior and complete optional SLA calculation.

**[➡️ Go to Challenge 2](./challenge2/README.md)**

## Labs

These labs stay in the module and fit naturally after the custom challenges.

### Networking reinforcement

- AZ-104 Lab 04: https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/Instructions/Labs/LAB_04-Implement_Virtual_Networking.html

### VM and Bastion reinforcement

- AZ-104 Lab 08: https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/Instructions/Labs/LAB_08-Manage_Virtual_Machines.html

### Web workload reinforcement

- AZ-900 Exercise 1: https://mslearn.cloudguides.com/en-us/guides/AZ-900%20Exam%20Guide%20-%20Azure%20Fundamentals%20Exercise%201

### Advanced stretch lab

- AZ-900 Exercise 2 (App Service): https://mslearn.cloudguides.com/en-us/guides/AZ-900%20Exam%20Guide%20-%20Azure%20Fundamentals%20Exercise%202

## Helpful Microsoft Learn references

<details>
<summary>💡 Why these references matter</summary>
<br>

These links are selected to support exactly what you build in Day 1:

- DNS: understand frontend name resolution.
- Bastion: secure VM access without exposing management ports.
- Load Balancer: backend pools, probes, and failover behavior.
- Reliability: tie architecture decisions to SLA thinking.

</details>

- Azure DNS overview: https://learn.microsoft.com/en-us/azure/dns/dns-overview
- Azure Bastion overview: https://learn.microsoft.com/en-us/azure/bastion/bastion-overview
- Azure Load Balancer overview: https://learn.microsoft.com/en-us/azure/load-balancer/load-balancer-overview
- Reliability in Azure: https://learn.microsoft.com/en-us/azure/reliability/overview

## Learning resources

- About Virtual machines and Virtual Machine Scale Sets: https://youtu.be/OykMc6wKMJY

## Continue

**[< back](../chapter-0/README.md) | [home](../../README.md) | [next >](../../day2/chapter-2/README.md) | [solutions](../../solutions/chapter-1/README.md)**
