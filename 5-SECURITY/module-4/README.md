# Module 4: Data Security at Rest
## Securing Storage and Database Services

### Overview
Data security at rest is crucial for protecting sensitive information stored in Azure. This module focuses on securing Azure Storage accounts and databases using encryption, access controls, and network isolation techniques.

### Learning Objectives
By completing this module, you will:
- Implement comprehensive Azure Storage security measures
- Configure storage account access controls and encryption
- Understand database security best practices in Azure
- Learn about private networking for data services (covered in Architecture hackathon)

### Prerequisites
- Completion of previous modules
- Storage account created in Module 1
- Understanding of data classification and protection needs

---

## Hands-On Tasks

### Task 1: Secure Your Storage Account
**Goal**: Implement comprehensive security measures for Azure Storage

**What you'll do**: Configure encryption, access controls, and security best practices for the storage account created in Module 1.

**Success Criteria**: 
- Storage account configured with appropriate encryption settings
- Access controls implemented following security best practices
- Understanding of Azure Storage security features
- Knowledge of when to use different access methods (keys, SAS, RBAC)

<details close>
<summary>💡 Hint: Look up Azure Storage security features </summary>
<br>

Review the [Security recommendations for Blob storage](https://learn.microsoft.com/en-us/azure/storage/blobs/security-recommendations).

</details>

### Task 2: Network Isolation for Storage (Architecture Module)
**Goal**: Configure firewall restrictions and private networking for storage

**What you'll learn**: How to limit storage access to authorized networks only using firewalls and Private Links.

> **Note**: This task is covered in detail during the Architecture hackathon where you'll implement VNet integration and Private Link connectivity.

### Task 3: Secure Azure Databases
**Goal**: Implement security controls for Azure SQL databases

**What you'll do**: Configure database encryption, firewall rules, and access controls for Azure SQL Database.

**Success Criteria**: 
- Database secured with encryption at rest and in transit
- Firewall rules configured to restrict access
- Appropriate authentication methods implemented
- Understanding of Azure SQL security features

### Task 4: Database Private Networking (Architecture Module)
**Goal**: Configure private connectivity for database services

**What you'll learn**: How to use Private Links and VNet service endpoints to secure database connectivity.

> **Note**: This advanced networking topic is covered during the Architecture hackathon where you'll implement end-to-end private connectivity.

---

## Learning Resources
- [Azure Storage encryption for data at rest](https://learn.microsoft.com/en-us/azure/storage/common/storage-service-encryption)
- [Security recommendations for Blob storage](https://learn.microsoft.com/en-us/azure/storage/blobs/security-recommendations)  
- [Tutorial: Secure a database in Azure SQL Database](https://learn.microsoft.com/en-us/azure/azure-sql/database/secure-database-tutorial)
- [Azure SQL Database security best practices](https://learn.microsoft.com/en-us/azure/azure-sql/database/security-best-practice)
**Success Criteria**: Databases are accessible only through authorized networks and firewall settings are configured properly.

**Navigation:**
- [< Previous Module 3 - Securing Applications](../module-3/README.md)
- [Next Module 5 - Securing Data in Use - Confidential Virtual Machines >](../module-5/README.md)
```