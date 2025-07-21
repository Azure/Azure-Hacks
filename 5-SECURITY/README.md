# Day 1: Azure Security Hackathon

## Welcome to Day 1!

Today we'll dive deep into Azure security fundamentals, exploring Zero Trust principles and implementing cloud security best practices. This hands-on security hackathon will establish the foundation for secure Azure deployments throughout the remaining days.

## Day 1 Objectives

By the end of today, you will:
- ✅ **Understand** Zero Trust security principles and how to apply them in Azure
- ✅ **Master** Azure identity and access management (IAM) with RBAC
- ✅ **Implement** network security using VNets, NSGs, and Private Links
- ✅ **Secure** Azure applications and data both at rest and in transit
- ✅ **Configure** monitoring, compliance, and governance for Azure resources
- ✅ **Experience** advanced security features like Confidential Computing

## Day 1 Schedule (6 hours total)

| Time | Duration | Activity |
|------|----------|----------|
| **Morning** | 2 hours | **Introduction & Context Setting**<br/>• Cloud fundamentals & Azure Landing Zones<br/>• Enterprise Hub & Spoke architecture<br/>• Zero Trust security model |
| **Afternoon** | 4 hours | **Security Hackathon Challenges**<br/>• 6 hands-on modules covering complete Azure security spectrum |

## Prerequisite Check

Before starting, ensure you have completed the [Setup Guide](../1-SETUP/README.md):
- ✅ Azure CLI installed and authenticated
- ✅ Azure Developer CLI (azd) installed
- ✅ Visual Studio Code ready
- ✅ Access to Azure environment
- ✅ Permissions to create resources in your Azure subscription

---

## Security Hackathon Challenges

The hackathon is structured in **6 progressive modules**, each building upon the previous ones. Follow them in sequence for the best learning experience.

### Module 1: Identity & Access Management
**[Authentication and Authorization](./module-1/README.md)**

**What you'll learn:** Master Azure identity fundamentals and Role-Based Access Control (RBAC)

**Key Skills:**
- View and manage user identities and permissions in Azure
- Understand Service Principals vs Managed Identities vs RBAC
- Assign and configure Azure roles (Owner, Contributor, Reader, Custom)
- Create and manage resource groups and storage accounts with proper permissions

**Hands-on Labs:**
1. **Identity Exploration** - View your current user identity and permissions
2. **Resource Creation** - Create Resource Group and Storage Account
3. **RBAC Configuration** - Assign different roles to resources and resource groups  
4. **Service Principal Setup** - Configure Service Principal and User Managed Identity
5. **Permission Auditing** - List and verify user permissions on storage resources

---

### Module 2: Network Security
**[Securing Virtual Networks](./module-2/README.md)**

**What you'll learn:** Implement network security using Azure networking services

**Key Skills:**
- Design and secure Virtual Networks (VNets)
- Configure Network Security Groups (NSGs) and Application Security Groups
- Implement network traffic filtering and micro-segmentation
- Associate network interfaces with security groups

**Hands-on Labs:**
1. **VNet Security** - Deploy secure Virtual Network infrastructure
2. **VM Deployment** - Deploy 2 VMs for network testing
3. **NSG Configuration** - Set up NSGs on subnets with Application Security Groups
4. **Traffic Rules** - Configure VM ports and NSG rules per Application Security Group
5. **Network Testing** - Associate VM NICs to security groups and test traffic filtering

---

### Module 3: Application Security  
**[Securing Applications](./module-3/README.md)**

**What you'll learn:** Secure Azure applications using identity-based access and firewall controls

**Key Skills:**
- Create and use Service Principals for application authentication
- Configure RBAC permissions for Service Principals and Managed Identities
- Implement App Service firewall and IP restrictions
- Secure application endpoints from unauthorized access

**Hands-on Labs:**
1. **Service Principal Creation** - Create service principal with password authentication
2. **RBAC Assignment** - Assign Azure RBAC permissions to Service Principals & Managed Identities  
3. **Resource Provisioning** - Create Azure resources using service principal authentication
4. **Firewall Configuration** - Secure App Services using IP restrictions for your client IP

---

### Module 4: Data Security at Rest
**[Securing Data at Rest](./module-4/README.md)**

**What you'll learn:** Protect stored data using encryption, firewalls, and private networking

**Key Skills:**
- Implement Azure Storage security best practices
- Configure storage account firewalls and private endpoints
- Secure Azure databases with advanced security features
- Design private networking for data services

**Hands-on Labs:**
1. **Storage Security** - Implement comprehensive Azure Storage security measures
2. **Network Isolation** - Configure firewall restrictions and Private Link for storage
3. **Database Security** - Secure Azure databases with encryption and access controls
4. **Private Connectivity** - Set up Private Link connections for databases
   
> **Note:** Network isolation topics are covered in detail during the Architecture hackathon

---

### Module 5: Confidential Computing
**[Securing Data in Use - Confidential Virtual Machines](./module-5/README.md)**

**What you'll learn:** Protect data while it's being processed using Azure's confidential computing

**Key Skills:**
- Understand confidential computing concepts and use cases
- Deploy and configure Confidential VMs
- Implement confidential boot disks for enhanced security
- Perform VM attestation for security verification

**Hands-on Labs:**
1. **Confidential VM Deployment** - Launch a Confidential VM with encrypted memory
2. **Confidential Boot Setup** - Configure confidential boot disk encryption
3. **VM Attestation** - Perform cryptographic attestation to verify VM security
4. **Security Validation** - Test and validate confidential computing protections

---

### Module 6: Governance & Compliance
**[Governance & Compliance](./module-6/README.md)**

**What you'll learn:** Implement governance, monitoring, and compliance using Microsoft Defender for Cloud

**Key Skills:**
- Configure Microsoft Defender for Cloud threat protection
- Analyze security recommendations and improve Secure Score
- Implement governance policies and compliance standards
- Use Attack Path Analysis for proactive threat detection

**Hands-on Labs:**
1. **Defender Setup** - Configure Defender for Cloud threat protection across your resources
2. **Security Assessment** - Review security recommendations and work on improving Secure Score
3. **Plan Management** - Determine which Defender plans are active and optimize coverage
4. **Attack Analysis** - Enable and utilize Attack Path Analysis for threat detection
5. **Policy Review** - Examine current governance policies and compliance standards

---

## Day 1 Wrap-Up

**What you've accomplished:**
- ✅ Built a comprehensive understanding of Azure security fundamentals
- ✅ Implemented Zero Trust principles across identity, network, and application layers
- ✅ Gained hands-on experience with advanced security features
- ✅ Established security foundations for the remaining hackathon days

**Next Steps:**
- **Day 2**: Apply these security principles in your architecture designs
- **Day 3**: Integrate security into your development and CI/CD pipelines  
- **Day 4**: Monitor and maintain security in production environments

---

## Need Help?

- **Stuck on a challenge?** Check the detailed instructions in each module
- **Technical issues?** Consult the [Setup Guide](../1-SETUP/README.md) troubleshooting section
- **Want to learn more?** Each module contains additional resources and documentation links

**Good luck with your Azure Security journey!**
