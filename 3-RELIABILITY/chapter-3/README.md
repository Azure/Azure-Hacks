# Chapter 3 - Backup

Even highly resilient systems need disaster preparedness approaches, in both architecture design and workload operations. On the data layer, you should have strategies that can repair workload state in case of corruption. Backups are essential to getting the system back to a working state by using a trusted recovery point, like the last-known good state.

## Learning Checkpoint - Backup Options

## What can you back up?

On Azure, here can be found an overview, which resources/Azure Services that can be backed up. In this chapter, we will focus on the backup of **Azure VMs** and **Database Backup**.

- **Azure VMs** - [Back up entire Windows/Linux VMs](backup-azure-vms-introduction.md) (using backup extensions) or back up files, folders, and system state using the [MARS agent](backup-azure-manage-mars.md).
- **Azure Managed Disks** - [Back up Azure Managed Disks](backup-managed-disks.md)
- **Azure Files shares** - [Back up Azure File shares to a storage account](backup-afs.md)
- **SQL Server in Azure VMs** -  [Back up SQL Server databases running on Azure VMs](backup-azure-sql-database.md)
- **SAP HANA databases in Azure VMs** - [Backup SAP HANA databases running on Azure VMs](backup-azure-sap-hana-database.md)
- **Azure Database for PostgreSQL servers** -  [Back up Azure PostgreSQL databases and retain the backups for up to 10 years](backup-azure-database-postgresql.md)
- **Azure Blobs** - [Overview of operational backup for Azure Blobs](blob-backup-overview.md)
- **Azure Database for PostgreSQL Flexible server** - [Overview of Azure Database for PostgreSQL Flexible server backup (preview)](backup-azure-database-postgresql-flex-overview.md)
- **Azure Kubernetes service** - [Overview of AKS backup](azure-kubernetes-service-backup-overview.md)
- **On-premises** - Back up files, folders, system state using the [Microsoft Azure Recovery Services (MARS) agent](backup-support-matrix-mars-agent.md). Or use the DPM or Azure Backup Server (MABS) agent to protect on-premises VMs ([Hyper-V](back-up-hyper-v-virtual-machines-mabs.md) and [VMware](backup-azure-backup-server-vmware.md)) and other [on-premises workloads](backup-mabs-protection-matrix.md)

💡 **Learning Resources**: 
- [What is the Azure Backup service?](https://learn.microsoft.com/en-us/azure/backup/backup-overview)
- [Azure Backup - Overview](https://azure.microsoft.com/en-us/products/backup/?msockid=2508f470901c684f1c68e76491fc69d9)

## Task 1: Enable Backup for the VM

1. **Setup Backup for VM1**
   - Go to **vm1** backup setup.
   - Create a backup policy for the VM.

2. **Add VM2 to Backup** 
   - Using the same **vault**, check on backup items.
   - Add **vm2** to the backup items.

💡 **Learning Resources**:
- [Azure VM backup](https://learn.microsoft.com/en-us/azure/backup/backup-azure-vms-introduction)

## Task 2: Enable Backup in Cosmos DB

Let's now go to the backup tab in your CosmosDB account and check the settings. CosmosDB has **periodical** and **continuous backup** features.

1. **Check Backup Settings in Cosmos DB**
   - Navigate to the backup tab in your CosmosDB account.

2. **Periodic Backups**
- The periodic backups are managed automatically by Azure. 
- You can configure some parameters in the ``Backup & Restore`` blade of the Cosmos DB account. For example, you can set the Backup Interval, which determines how often a new backup is created, and the Backup Retention, which specifies how long each backup is kept. 
- The backups are stored internally in an Azure Blob Storage in the same region as one of the write locations of the Cosmos DB account. Each backup gets an additional copy based on the Backup storage redundancy parameter.

3. **Continuous Backup**
   - Now let's see how the continuous backup works and how one can set it up. You can read more information on what that implies in the link [Migrate CosmosDB to Continuous Backup](https://learn.microsoft.com/en-us/azure/cosmos-db/migrate-continuous-backup). 

After completing the migration, you are done with Chapter 3!

💡 **Learning Resources**:
- [Online backup and on-demand data restore in Azure Cosmos DB](https://learn.microsoft.com/en-us/azure/cosmos-db/online-backup-and-restore)

## Success Criteria 🎉

- 🎊 **Congratulations!** Backup for **vm1** and **vm2** was enabled and one backup was performed.
- ✅ **CosmosDB Account** You understood how backups are done for CosmosDB and migrated to continuous backup.

**| [next Chapter 4 - Failover and Restore >](../chapter-4/README.md)** | 
 **[< previous Chapter 2 - Data Redundancy ](../chapter-2/README.md)**