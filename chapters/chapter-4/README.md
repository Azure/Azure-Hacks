# Chapter 4 - Compute & Storage

## Goal

The goal of this chapter is to provide an overview of Azure Compute and Storage services. 
By the end of this chapter, participants will be able to utilize Azure's compute and storage solutions to build, deploy, and manage applications in the cloud.

In this chapter we will cover the following topics:

### Compute

- Virtual Machines (VMs)
- Containers
- Azure Kubernetes Services (AKS)
- Web App
- Azure Container Instances (ACI)
- Azure Container Apps (ACA)
- Azure Functions

## Theory

### Azure Compute

> [!CAUTION]
> For all the following topics there are slides available for the instructor (and these will be shared with the participants): <https://microsofteur-my.sharepoint.com/:p:/g/personal/demirsenturk_microsoft_com/EQHcW09dFPxAuVGs6ValSV4BGbjnvQ_gMgl7-MNajSd9sw?e=Om1ee3>

### DEMO - Administer PaaS Compute Options

In this demonstration, we will create and work with Azure App Service plans.

Reference: [Manage App Service plan - Azure App Service](https://docs.microsoft.com/azure/app-service/app-service-plan-manage)

Reference: [Scale up an app in Azure App Service](https://learn.microsoft.com/azure/app-service/manage-scale-up)

Reference: [Automatic scaling in Azure App Service](https://learn.microsoft.com/azure/app-service/manage-automatic-scaling?tabs=azure-portal)

> [!CAUTION]
> Please follow the instructions to DEMO: <https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/Instructions/Demos/07%20-%20Administer%20Azure%20Storage.html>

### 01a - Implement Web Apps

> [!IMPORTANT]
> Please follow the instructions in this lab - **Exercise 15min**: <https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/Instructions/Labs/LAB_09a-Implement_Web_Apps.html>

### Lab 01b - Implement Azure Container Instances

> [!IMPORTANT]
> Please follow the instructions in this lab - **Exercise 15min**: <https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/Instructions/Labs/LAB_09b-Implement_Azure_Container_Instances.html>

### Lab 01c - Implement Azure Container Apps

> [!IMPORTANT]
> Please follow the instructions in this lab - **Exercise 15min**: <https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/Instructions/Labs/LAB_09c-Implement-Azure-Container-Apps.html>

### Azure Storage

- Azure Storage Accounts
- Azure Blob Storage
- Aure Disk Storage
- Azure File Shares
- Azure Data Box

## Theory

### Azure Storage

> [!CAUTION]
> For all the following topics there are slides available for the instructor (and these will be shared with the participants): <https://microsofteur-my.sharepoint.com/:p:/g/personal/demirsenturk_microsoft_com/EXR4MzYvRt9BrubZKoyz-ekB1LcXyot49gitmRAB5uT3oQ?e=b59N9t>

### DEMO - Administer Azure Storage

> [!CAUTION]
> Please follow the instructions to DEMO: <https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/Instructions/Demos/07%20-%20Administer%20Azure%20Storage.html>

### Lab 01 - Manage Azure Storage

In this lab you learn to create storage accounts for Azure blobs and Azure files. You learn to configure and secure blob containers. You also learn to use Storage Browser to configure and secure Azure file shares.

> [!IMPORTANT]
> Please follow the instructions in this lab - **Exercise 50min**: <https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/Instructions/Labs/LAB_07-Manage_Azure_Storage.html>

## Lab 02 - Data Science Tooling - Working with Storage & Databases

### Actions

* Deploy a Windows Server 2022 VM in Germany West Central Resource Group. Please use the "Data Science Virtual Machine - Windows 2022" image from the market place.
  > **Note:** The 'Data Science Virtual Machine (DSVM)' is a 'Windows Server 2022 with Containers' VM that has several popular tools for data exploration, analysis, modeling & development pre-installed.
  > You will use **Microsoft SQL Server Management Studio** to connect to the database and **Storage Explorer** to the storage Account.
* Create a blob container and upload a sample file to it.
* From the Data Science Windows Server VM, connect to the storage account.
* OPTIONAL - Deploy an Azure SQL database server with a database containing the sample data of AdventureWorksLT.
* OPTIONAL - From the Data Science Windows Server VM, connect to the database.

### Success Criteria ✅
* You have deployed a VM in Azure (one with Windows Server 2022 - Data Science Virtual Machine).
* You have deployed an Azure SQL database with sample data (AdventureWorksLT) and can access the database from the Windows Server (Data Science Edition).
* You successfully connected to the database and the storage account from the Windows Server.

## Continue

**[home](../../README.md) | [next >](../chapter-5/README.md) | [solutions](../../solutions/chapter-4/README.md)**