# Chapter 4 - Replicate and Restore

## Task 1: Restore VM from Backup in the same Region

1. Navigate to the **Azure Portal** and access your **Recovery Services vault**.
2. Select **Backup items** under the **Protected items** section.
3. Choose the **VM** you intend to restore from the list.
4. Click on **Restore VM**.
5. In the **Restore Configuration** blade:
    - Select the **Restore Point** you wish to use.
    - Choose **Create new** for the Resource Group and Virtual Network, or use existing ones.
    - For **Storage Account**, either select an existing one or create a new one if necessary.
6. Click **OK** to proceed.
7. Wait for the deployment to complete. You can monitor the progress in the **Notifications**.

After the deployment completes, verify that the VM is restored and running correctly by navigating to the **Virtual Machines** section in the Azure Portal.

## Task 2: Replication - Failover VM to a Secondary Region

Enable disaster Recovery for **vm1** by checking under Site Recovery. Select the secondary region of your choice as a target region to replicate the VM. In advance settings, you can choose the name of the resource group and vnet you want to use for the DR settings. Since we do not have any set up in another region, use the suggested name.

Enable disaster recovery for **vm1** by configuring Site Recovery:

1. Navigate to **vm1** in the **Azure Portal**.
2. Under the **Operations** section, select **Disaster recovery**.
3. In the **Configure disaster recovery** blade:
    - Choose your desired **Secondary Region** as the target region for replication.
    - Configure the **Resource Group** and **Virtual Network** for the secondary region.
4. Accept the default options for the remaining settings or customize them as per your requirements.
5. Click **Review + start replication** to begin the process.

You can check the replication status under the **Disaster Recovery** tab of **vm1**. The process might take some time.

Once replication is complete, perform a **Test Failover**:
1. In the **Disaster Recovery** tab, select **Test failover**.
2. Use the default settings provided.
3. Verify the test failover by checking the public IP address and making sure that the web server is accessible.
4. After verification, clean up the test failover to ensure no resources are left unused.

## Task 3: Replication - Failover vm to a secondary region

You can check the status of the replication when the job finishes (it can take a while, so I suggest moving over to the next task) by looking again in the Disaster Recovery tab of the vm. You can see the Health and Status information of the replication, as well as a visual overview of the infrastructure.

After the replication is done, you are ready to run a drill and make sure the disaster recovery works as expected. In the disaste recovery tab, select test failover. Use default settings. Check which public ip address the replicated vm has. Test out if you can still see the web server. After that, don't forget to cleanup using the cleanup test failover option.

## Task 4: Restore CosmosDB to a second account

You can restore your cosmosDB account based on the continuous backup you started in [chapter-3](../chapter-3/README.md). First, let's delete or add some [containers](https://learn.microsoft.com/en-us/azure/cosmos-db/nosql/how-to-create-container) to be able to visualize what'S going on.

Now, go to the Point in Time Restore tab in your cosmosDB account, choose restore to new account. You can choose a restore point (a timestamp) that you want to use to restore. Choose location and name for the new account. If you want, you can also granular choose which datasets you want to include in the restore.

After deployment is complete, go to your "restored" new account and check on Data Explorer that all the data got restored.

## Success Criteria 🎉

- 🎊 **Congratulations!** You failover vm1 to a second region.
- ✅ **CosmosDB Account** You restored CosmosDB account from the continuos backup to a second account.

**| [next Chapter 5 - Implement overall monitoring and logging >](../chapter-5/README.md)** | 
 **[< previous Chapter 3 - Backup](../chapter-3/README.md)**