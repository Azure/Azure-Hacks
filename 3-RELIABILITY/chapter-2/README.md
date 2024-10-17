# Chapter 2 - Data Redundancy

Storage redundancy mechanisms store multiple copies of your data so that it's protected from planned and unplanned events. These events can include transient hardware failure, network or power outages, or massive natural disasters.

## Task 1: Manage data disks in the Virtual Machines

Add in **vm1** a zone redundant data disk.

<details close>
<summary>💡 Hint</summary>
<br>

Under Settings, go to Disks, Create and attach a new disk.

</details>

## Task 2: Expanding Azure Cosmos DB to a second region

Storage redundancy in multi-region deployment. Go to your cosmos db instance and replicate data to a second region. You can use `switzerlandnorth` region.

<details close>
<summary>💡 Hint</summary>
<br>

Under Settings, go to Replicate data globally, click on the region you want to add on the map, or the buttle **+ Add region**.

</details>

💡 **Learning Resources**: 
- [Understanding multi-region writes in Azure Cosmos DB](https://learn.microsoft.com/en-us/azure/cosmos-db/multi-region-writes)
- [Set up global distribution using Azure Cosmos DB](https://learn.microsoft.com/en-us/azure/cosmos-db/nosql/tutorial-global-distribution?tabs=dotnetv2%2Capi-async)

## Success Criteria 🎉

- 🎊 **Congratulations!** You have successfully added a zone redundant data disk to **vm1**.
- ✅ **TODO Application** You added redundancy of Cosmos DB database to second region.

**| [next  Chapter 3 - Backup >](../chapter-3/README.md)** | 
 **[< previous Chapter 1 - Zonal Redundancy ](../chapter-1/README.md)**