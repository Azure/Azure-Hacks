# Module 2 - Securing Networks

### Hands-On Tasks

## Task 1: Securing Virtual Networks
- **Instructions:** Implement security measures for virtual networks.
- **Success Criteria:** Virtual network created in a proper Zone.
  
📘 **How-To Guide:** [How to create a Virtual Network](https://learn.microsoft.com/en-us/azure/virtual-network/quick-create-portal)

<details close>
<summary>💡 Hint: Create a virtual network</summary>
<br>

1. **Sign in to the Azure Portal**
   - Go to: [Azure Portal](https://portal.azure.com/).
   - **Note:** Use an account with the Owner or Contributor role in the Azure subscription you are using for this lab.

2. **Navigate to Virtual Networks**
   - In the Azure portal, use the **Search resources, services, and docs** text box at the top.
   - Type **Virtual networks** and press **Enter**.

3. **Create a Virtual Network**
   - On the **Virtual networks** blade, click **+ Create**.

4. **Configure Basic Settings**
   - On the **Basics** tab of the **Create virtual network** blade, specify the following settings and click **Next: IP Addresses**:
     - **Subscription:** Select the Azure subscription you are using for this lab.
     - **Resource group:** Click **Create new** and enter **MY_RG_CLOUD_ACADEMY**.
     - **Name:** Enter **CLOUDACADEMYVirtualNetwork**.
     - **Region:** Select **(Africa) South Africa North**.

5. **Configure IP Addresses**
   - On the **IP addresses** tab, set the **IPv4 address space** to **10.0.0.0/16**.
   - If needed, in the **Subnet name** column, click **default**, and on the **Edit subnet** blade, specify the following settings and click **Save**:
     - **Subnet name:** Enter **SRVSubnetwork**.
     - **Subnet address range:** Enter **10.0.0.0/24**.

6. **Review and Create**
   - Back on the **IP addresses** tab, click **Review + create**.
   - On the **Review + create** tab, click **Create**.

</details>

### Result
🎊 **Congratulations!** You have successfully created a Virtual Network.

💡 **Learning Resources:**
- [What is Azure Virtual Network?](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview)

## Task 2: Deploying Required VMs
- **Instructions:** Deploy 2 VMs to link them.
- **Success Criteria:** Ubuntu Server and Windows Server 2022 VMs deployed.

📘 **How-To Guide:** 
- [Create a Windows virtual machine in the Azure portal](https://learn.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-portal)
- [Create a Linux virtual machine in the Azure portal](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-portal?tabs=ubuntu)

<details close>
<summary>💡 Hint 1: Deploy a Windows Server VM</summary>
<br>

## Creating Windows Server VM

1. **Navigation to Virtual Machines**
   - In the Azure portal, navigate to the **Virtual machines** blade.
   - Click **+ Create** and then select **+ Azure virtual machine** from the dropdown list.

2. **Configure Basic Settings for Windows VM**
   - On the **Basics** tab of the **Create a virtual machine** blade, specify the following settings:

     |Setting|Value|
     |---|---|
     |Subscription|Select the Azure subscription you are using for this lab|
     |Resource group|**MY_RG_CLOUD_ACADEMY**|
     |Virtual machine name|**CLOUDacademyVMwinSRV**|
     |Region|**(Africa) South Africa North**|
     |Image|**Windows Server 2022 Datacenter: Azure Edition - x64 Gen2**|
     |Size|**Standard D2s v3**|
     |Username|**Define your own user**|
     |Password|**Define your own password**|
     |Public inbound ports|**None**|
     |Already have a Windows Server license?|**No**|

     > **Note:** We will configure public inbound ports in the subsequent NSG task.

3. **Configure Disks**
   - Click **Next: Disks >**.
   - On the **Disks** tab, set the **OS disk type** to **Standard HDD**.
   - Click **Next: Networking >**.

4. **Configure Networking**
   - On the **Networking** tab, select the previously created network **WindowsSRVSubnetwork**.
   - Under **NIC network security group**, select **None**.

5. **Configure Management and Monitoring**
   - Click **Next: Management >**, then **Next: Monitoring >**.
   - On the **Monitoring** tab, ensure the following setting:

     |Setting|Value|
     |---|---|
     |Boot diagnostics|**Enabled with managed storage account (recommended)**|

6. **Review and Create**
   - Click **Review + create**.
   - On the **Review + create** blade, ensure that validation was successful and click **Create**.

</details>

<details close>
<summary>💡 Hint 2:  Deploy a Linux Server VM</summary>
<br>

## Creating Linux Server VM

1. **Navigation to Virtual Machines**
   - In the Azure portal, navigate to the **Virtual machines** blade.
   - Click **+ Create** and then select **+ Azure virtual machine** from the dropdown list.

2. **Configure Basic Settings for Linux VM**
   - On the **Basics** tab of the **Create a virtual machine** blade, specify the following settings:

     |Setting|Value|
     |---|---|
     |Subscription|Select the Azure subscription you are using for this lab|
     |Resource group|**MY_RG_CLOUD_ACADEMY**|
     |Virtual machine name|**CLOUDacademyVMlinuxSRV**|
     |Region|**(Africa) South Africa North**|
     |Image|**Ubuntu Server 24.04 LTS - x64 Gen2**|
     |Size|**Standard_B2ls_v2**|
     |Username|**Define your own user**|
     |Password|**Define your own password**|
     |Public inbound ports|**None**|

     > **Note:** We will configure public inbound ports in the subsequent NSG task.

3. **Configure Disks**
   - Click **Next: Disks >**.
   - On the **Disks** tab, set the **OS disk type** to **Standard HDD**.
   - Click **Next: Networking >**.

4. **Configure Networking**
   - On the **Networking** tab, select the previously created network **WindowsSRVSubnetwork**.
   - Under **NIC network security group**, select **None**.

5. **Configure Management and Monitoring**
   - Click **Next: Management >**, then **Next: Monitoring >**.
   - On the **Monitoring** tab, ensure the following setting:

     |Setting|Value|
     |---|---|
     |Boot diagnostics|**Enabled with managed storage account (recommended)**|

6. **Review and Create**
   - Click **Review + create**.
   - On the **Review + create** blade, ensure that validation was successful and click **Create**.

> **Note:** Wait for both virtual machines to be provisioned before continuing.

</details>

### Result
🎊 **Congratulations!** You have successfully deployed Ubuntu Server and Windows Server 2022 Virtual Machines.

💡 **Learning Resources:**
- [Virtual machines in Azure](https://learn.microsoft.com/en-us/azure/virtual-machines/overview)
- [Security features used with Azure VMs - Azure security](https://learn.microsoft.com/en-us/azure/security/fundamentals/virtual-machines-overview?toc=%2Fazure%2Fvirtual-machines%2Ftoc.json)

## Task 3: NSG on Subnet & Application Security Groups
- **Instructions:** Configure Network Security Groups (NSGs) on subnet and set up application security groups.
- **Success Criteria:**
  - NSG(s) should be deployed.
  - At least 2 application security groups created.
  - Base policies reviewed and tuned if needed.

📘 **How-To Guide:** [Filter network traffic with a network security group using the Azure portal](https://learn.microsoft.com/en-us/azure/virtual-network/tutorial-filter-network-traffic?tabs=portal)

<details close>
<summary>💡 Hint 1: Create Application Security Group for Windows Servers</summary>
<br>

### Create Application Security Group for Windows Servers

1. **Search for Application Security Groups**
   - In the Azure portal, type **Application security groups** in the **Search resources, services, and docs** text box at the top of the page and press **Enter**.

2. **Create a New Application Security Group**
   - On the **Application security groups** blade, click **+ Create**.

3. **Configure Basic Settings for Windows Security Group**
   - On the **Basics** tab, specify the following settings:

     |Setting|Value|
     |---|---|
     |Resource group|**MY_RG_CLOUD_ACADEMY**|
     |Name|**AsgWindowsServers**|
     |Region|**(Africa) South Africa North**|

     > **Note:** This group will be for the web servers.

4. **Review and Create**
   - Click **Review + create**, ensure the settings are correct, and click **Create**.

</details>

<details close>
<summary>💡 Hint 2: Create Application Security Group for Linux Servers</summary>
<br>

### Create Application Security Group for Linux Servers

5. **Create Another Application Security Group**
   - Navigate back to the **Application security groups** blade and click **+ Create**.

6. **Configure Basic Settings for Linux Security Group**
   - On the **Basics** tab, specify the following settings:

     |Setting|Value|
     |---|---|
     |Resource group|**MY_RG_CLOUD_ACADEMY**|
     |Name|**AsgLinuxServers**|
     |Region|**(Africa) South Africa North**|

     > **Note:** This group will be for the management servers.

7. **Review and Create**
   - Click **Review + create**, ensure the settings are correct, and click **Create**.

</details>

<details close>
<summary>💡 Hint 3: Create a Network Security Group (NSG)</summary>
<br>

## Create a Network Security Group (NSG)

### Create the NSG

1. **Search for Network Security Groups**
   - In the Azure portal, type **Network security groups** in the **Search resources, services, and docs** text box at the top of the page and press **Enter**.

2. **Create a New Network Security Group**
   - On the **Network security groups** blade, click **+ Create**.

3. **Configure Basic Settings for the NSG**
   - On the **Basics** tab, specify the following settings:

     |Setting|Value|
     |---|---|
     |Subscription|Select the Azure subscription you are using for this lab|
     |Resource group|**MY_RG_CLOUD_ACADEMY**|
     |Name|**accessNsg**|
     |Region|**(Africa) South Africa North**|

4. **Review and Create**
   - Click **Review + create**, ensure the settings are correct, and click **Create**.

</details>

<details close>
<summary>💡 Hint 4: Associate the NSG with the Subnet</summary>
<br>

### Associate the NSG with the Subnet

5. **Navigate to the Newly Created NSG**
   - In the Azure portal, navigate back to the **Network security groups** blade and click on the **accessNsg** entry.

6. **Associate the NSG with the Subnet**
   - On the **accessNsg** blade, in the **Settings** section, click **Subnets**.
   - Click **+ Associate**.

7. **Configure Association Settings**
   - On the **Associate subnet** blade, specify the following settings and click **OK**:

     |Setting|Value|
     |---|---|
     |Virtual network|**CLOUDACADEMYVirtualNetwork**|
     |Subnet|**default**|

</details>

## Task 4: VM Ports and NSG Rules per Application Security Group
- **Instructions:** Manage VM ports and configure NSG rules for each Application Security Group.
- **Success Criteria:**
  - Only required ports should be allowed.
  - All other traffic should be explicitly denied.

📘 **How-To Guide:** [Restrict network access for a subnet](https://learn.microsoft.com/en-us/azure/virtual-network/tutorial-restrict-network-access-to-resources?tabs=portal#restrict-network-access-for-a-subnet)

<details close>
<summary>💡 Hint: Create inbound NSG security rules to allow trafic</summary>
<br>

## Instructions for Configuring Inbound Security Rules

### Step 0: Define Your IP Address
Determine your IP address using any IP service, such as [WhatIsMyIP](https://whatismyipaddress.com/).

### Step 1: Access Inbound Security Rules
1. Navigate to the **accessNsg** blade.
2. In the **Settings** section, click on **Inbound security rules**.

### Step 2: Add SSH Inbound Rule
1. Review the default inbound security rules.
2. Click **+ Add** to create a new inbound security rule.
3. On the **Add inbound security rule** blade, configure the following settings to allow SSH (port 22) to the **AsgLinuxServers** application security group:

    | Setting                    | Value                                               |
    |----------------------------|-----------------------------------------------------|
    | Source                     | IP Address                                          |
    | Source IP addresses        | Your IP Address (from Step 0)                       |
    | Destination                | Application security group -> **AsgLinuxServers**   |
    | Destination port ranges    | **22**                                               |
    | Protocol                   | **TCP**                                              |
    | Priority                   | **100**                                              |
    | Name                       | **Allow-SSH-for-ME**                                 |

4. Click **Add** to finalize the new inbound rule.

### Step 3: Add RDP Inbound Rule
1. On the **accessNsg** blade, in the **Settings** section, click **Inbound security rules**.
2. Click **+ Add** to create a new inbound security rule.
3. On the **Add inbound security rule** blade, configure the following settings to allow RDP (port 3389) to the **AsgWindowsServers** application security group:

    | Setting                    | Value                                                    |
    |----------------------------|----------------------------------------------------------|
    | Source                     | IP Address                                               |
    | Source IP addresses        | Your IP Address (from Step 0)                            |
    | Destination                | Application security group -> **AsgWindowsServers**      |
    | Destination port ranges    | **3389**                                                 |
    | Protocol                   | **TCP**                                                  |
    | Priority                   | **110**                                                  |
    | Name                       | **Allow-RDP-for-ME**                                     |

4. Click **Add** to finalize the new inbound rule.

</details>

### Result
🎊 **Congratulations!** You have successfully configured a virtual network, network security with inbound security rules, and two application security groups.

💡 **Learning Resources:**
- [Application security groups](https://learn.microsoft.com/en-us/azure/virtual-network/application-security-groups)
- [Network security groups](https://learn.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview)

## Task 5: Associate Each Virtual Machine's NIC to Its Application Security Group and Test Network Traffic Filtering
- **Instructions:** Associate each virtual machine's network interface with the corresponding application security group.
- **Success Criteria:**
  - Test the network traffic filters.
  - You should be able to connect via RDP and SSH into corresponding virtual machines.

<details close>
<summary>💡 Hint 1: Steps for Verifying and Configuring Virtual Machines </summary>
<br>

## Steps for Verifying and Configuring Virtual Machines

### Step 1: Verify Virtual Machines Status
1. In the Azure portal, navigate back to the **Virtual machines** blade.
2. Ensure that both virtual machines are listed and showing a **Running** status.

### Step 2: Configure **CLOUDacademyVMlinuxSRV**
1. From the list of virtual machines, click on **CLOUDacademyVMlinuxSRV**.
2. On the **CLOUDacademyVMlinuxSRV** blade, go to the **Networking** section.
3. Click **Network settings** and then select the **Application security groups** tab.
4. Click **+ Add application security groups**.
5. In the **Application security group** list, select **AsgLinuxServers** and click **Save**.

### Step 3: Configure **CLOUDacademyVMwinSRV**
1. Navigate back to the **Virtual machines** blade.
2. From the list of virtual machines, click on **CLOUDacademyVMwinSRV**.
3. On the **CLOUDacademyVMwinSRV** blade, go to the **Networking** section.
4. Click **Network settings** and then select the **Application security groups** tab.
5. Click **+ Add application security groups**.
6. In the **Application security group** list, select **AsgWindowsServers** and click **Save**.

</details>

<details close>
<summary>💡 Hint 2: Test the network traffic filtering </summary>
<br>

### Testing Network Traffic Filtering

### Step 1: Connect to **CLOUDacademyVMwinSRV** via RDP
1. Navigate back to the **CLOUDacademyVMwinSRV** virtual machine blade.
2. Click **Connect** and choose **RDP** from the drop-down menu.
3. Click **Download RDP File** and use it to connect to the **CLOUDacademyVMwinSRV** Azure VM via Remote Desktop.
4. When prompted, authenticate using the credentials provided in Task 2.

    > **Note**: Verify that the Remote Desktop connection is successful to confirm you can connect to **CLOUDacademyVMwinSRV** via RDP.

### Step 2: Connect to **CLOUDacademyVMlinuxSRV** via SSH
1. Open PowerShell on your local machine.
2. Use the following command to connect via SSH:

   ```sh
    ssh <YOUR_USER_CREATED>@<IP_ADDRESS_DEFINED_IN_STEP_0>
   ```

   Example:

   ```sh
    ssh nonether3@20.218.160.157
   ```

</details>

## Success Criteria 🎉
- 🎊 **Congratulations!** You have successfully validated that the NSG and ASG configurations are operational, and network traffic is being correctly managed.

💡 **Learning Resources**:
- [Network security concepts and requirements in Azure | Microsoft Learn](https://learn.microsoft.com/en-us/azure/security/fundamentals/network-overview) 
- [Azure Virtual Network - Concepts and best practices | Microsoft Learn](https://learn.microsoft.com/en-us/azure/virtual-network/concepts-and-best-practices)

 **[< previous Module 1 - Authentication and Authorization](../module-1/README.md) | [next Module 3 - Securing Applications >](../module-3/README.md)**
