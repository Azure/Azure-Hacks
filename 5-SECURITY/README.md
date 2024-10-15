# Microsoft Cloud Security Training

### Agenda
- **Introduction to Microsoft Cloud Security**
  - Overview of key concepts and principles in cloud security.
  - Importance of Microsoft Cloud Security solutions.

## [Module 1 - Authentication and Authorization](./module-1/README.md)
- **Securing Identities and Access Permissions**
- **Review Identity Provider Architecture for Azure and Applications**

### Hands-On Tasks:
- **View Logged-In User Identity and Current Permissions**
  - Explore how to view the current user’s identity and permissions in Azure.
- **Assign Roles to Resources and Resource Groups**
  - Assign different roles to resources and resource groups in Azure.
- **Learning Checkpoint: Configure a Service Principal and User Managed Identity**
  - (Theory) What are service principals and user-managed identities? What is the difference from RBAC?
- **Create a Resource Group**
- **Create a Storage Account**
- **Configure Azure Roles (Owner, Contributor, Reader, and Custom Roles)**
  - Set up various Azure roles and custom roles.
- **List a User's Permissions on a Storage Account**

## [Module 2 - Securing Networks](./module-2/README.md)
- **Securing Virtual Networks**
  - Overview of virtual network security concepts and best practices.
  
### Hands-On Tasks:
- **Securing Virtual Networks**
  - Implement security measures for virtual networks.
- **Deploying Required VMs**
  - Deploy 2 VMs to link them.
- **NSG on Subnet & Application Security Groups**
  - Configure Network Security Groups (NSGs) on subnet and set up application security groups.
- **VM Ports and NSG Rules per Application Security Group**
  - Manage VM ports and configure NSG rules for each Application Security Group.
- **Associate Each Virtual Machine's NIC to Its Application Security Group and Test Network Traffic Filtering**
  - Associate each virtual machine's network interface with the corresponding application security group.

## [Module 3 - Securing Applications](./module-3/README.md)
- **Securing Applications**
  - Introduction to securing Azure applications through RBAC and firewall settings.

### Hands-On Tasks:
- **Create a service principal**
  - Create and use a service principal password with access.
- **Assign Azure RBAC Permission to Service Principals & Managed Identities**
  - Set up Azure Role-Based Access Control (RBAC) permissions for service principals and managed identities.
- **Create a resource using a service principal**

- **Secure App Services Using Firewall IP Restrictions to Allow Only Your Client IP**
  - Configure firewall IP restrictions to secure app services.

## [Module 4 - Securing Data at Rest](./module-4/README.md)
- **Securing Data at Rest**
  - Overview of best practices for securing data at rest in Azure.

### Hands-On Tasks:
- **Securing Storage**
  - Implement security measures for Azure Storage.
- **Configure Firewall Restrictions and Private Link (Covered in Architecting Part)**
  - Set up firewall restrictions and configure private link for storage.
- **Securing Databases**
  - Secure your databases using Azure tools.
- **Configure Firewall Restrictions and Private Link for Databases (Covered in Architecting Part)**
  - Set up firewall restrictions and configure private link for databases.

## [Module 5 - Securing Data in Use - Confidential Virtual Machines](./module-5/README.md)
- **Securing Data in Use**
  - Explanation of confidential computing and its significance in protecting data in use.

### Hands-On Tasks:
- **Deploy a Confidential VM and a Confidential Boot Disk**
  - Launch a confidential VM and set up a confidential boot disk.
- **Attesting the VM**
  - Perform attestation of the VM to ensure security.

## [Module 6 - Governance & Compliance](./module-6/README.md)
- **Governance & Compliance**
  - Understanding the importance of governance and compliance in cloud security.

### Hands-On Tasks:
- **Defender for Cloud Threat Protection**
  - Review and implement threat protection using Defender for Cloud.
- **Review Recommendations and Secure Score**
  - Analyze security recommendations and secure scores.
- **Determine Which Defender Plans Are Active**
  - Identify active Defender plans.
- **Enable Attack Path Analysis**
  - Enable and utilize attack path analysis.
- **View Current Policies and Standards**
  - Review the current governance policies and standards in place.
