# Module 3 - Securing Applications

In this module, you will focus on prerequisit tasks for securing your applications by creating managed identity and assigning appropriate permissions.

## Hands-On Tasks

### Task 1: Create a service principal
- **Instructions:** This step in the tutorial explains how to create and use a service principal password with access.
- **Success Criteria:** You are able to log in using a service principal password to access an Azure resource.
  
📘 **How-To Guide:** [Create an Azure service principal with Azure CLI
]( https://learn.microsoft.com/en-us/cli/azure/azure-cli-sp-tutorial-1?tabs=bash)

<details close>
<summary>💡 Hint: Create a service principle</summary>
<br>

1. **Sign in to the Azure Portal**
   - Go to: [Azure Portal](https://portal.azure.com/).
   - **Note:** Use an account with the Owner or Contributor role in the Azure subscription you are using for this lab.

2.  #### Using Azure CLI
Execute the following command to create a service principle:

```sh
az ad sp create-for-rbac --name myServicePrincipalCloudAcademy --role reader --scopes /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myRG1 
```

**Example:**

```sh
az ad sp create-for-rbac --name myServicePrincipalCloudAcademy --role reader --scopes /subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/Security-TESTs
```
</details>

### Result
🎊 **Congratulations!** You have successfully created a service principle.

💡 **Learning Resources:**
- [Use an Azure service principal with password-based authentication
]( https://learn.microsoft.com/en-us/cli/azure/azure-cli-sp-tutorial-2)

📘 **Theory Explained**: [Understanding App Objects and Service Principals in Azure](https://learn.microsoft.com/en-us/entra/identity-platform/app-objects-and-service-principals?tabs=browser)



### Task 2: Create or remove a role assignment
- **Instructions:** In order to restrict access to your Azure resources, you can use a service principal to manage role assignments. Each role provides different permissions allowed by the user when accessing Azure resources. This step in the tutorial explains how to create and remove service principal roles.
- **Success Criteria:** You has full permissions to read and write to an Azure Resource Group with The Contributor role. 

💡 **Hint**: The Reader role is more restrictive with read-only access. Always use the principle of least privilege. For a complete list of available roles in Azure RBAC, see [Azure built-in roles]( https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles).
  
📘 **How-To Guide:** [Manage service principal roles]( https://learn.microsoft.com/en-us/cli/azure/azure-cli-sp-tutorial-5)

<details close>
<summary>💡 Hint: Add a Contributor assigned permissions</summary>
<br>

1. **Sign in to the Azure Portal**
   - Go to: [Azure Portal](https://portal.azure.com/).
   - **Note:** Use an account with the Owner or Contributor role in the Azure subscription you are using for this lab.

2. **Using Azure CLI**
Execute the following command to assign Contributor permissions to Your previously service principle:

```sh
az role assignment delete--assignee myServicePrincipalID --role Reader --scope /subscriptions/mySubscriptionID/resourceGroups/myResourceGroupName

az role assignment create --assignee myServicePrincipalID --role Contributor --scope /subscriptions/mySubscriptionID/resourceGroups/myResourceGroupName
```

**Example:**

```sh

az role assignment delete --assignee d8XXXXXX-XXXX-XXXX-XXXX-XXXXXXXXX07a --role Reader --scope /subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/Security-TESTs

az role assignment create --assignee d8XXXXXX-XXXX-XXXX-XXXX-XXXXXXXXX07a --role Contributor --scope / subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/Security-TESTs
```

**Please put your credentials into example!**

</details>

### Result
🎊 **Congratulations!** You have successfully  assigned a Contributor permissions to Your previously service principle.

💡 **Learning Resources:**
- [az role assignment list command]( https://learn.microsoft.com/en-us/cli/azure/role/assignment?view=azure-cli-latest#az-role-assignment-list)


💡 **Hint**: Follow the step-by-step guide above to ensure proper role assignment.

###  Task 3: Create a resource using a service principal
- **Instructions:** If given the necessary permissions, a service principal can create and manage Azure resources just like an account. This tutorial step provides an example of how to create a resource for Azure Storage using a service principal
- **Success Criteria:** Azure storage account created with the proper permissions.

💡 **Hint**: The Storage account will be used in other tasks [Azure Storage]( https://learn.microsoft.com/en-us/azure/storage/).
  
📘 **How-To Guide:** [Create a resource using a service principal]( https://learn.microsoft.com/en-us/cli/azure/azure-cli-sp-tutorial-6)

<details close>
<summary>💡 Hint: How to create a resource for Azure Storage using a service principal </summary>
<br>

1. **Sign in to the Azure Portal**
   - Go to: [Azure Portal](https://portal.azure.com/).
   - **Note:** Use an account with the Owner or Contributor role in the Azure subscription you are using for this lab.

2. **Using Azure CLI**
To sign in with a service principal, you need to reuse credentials with which  you created a service principal in Task 1.

```sh

az login --service-principal -u <app-id> -p <password-or-cert> --tenant <tenant>

```

**Example:**

```sh

az login --service-principal -u d8XXXXXX-XXXX-XXXX-XXXX-XXXXXXXXX07a -p XXXXXXXXxXXXXxXXXXxXXXXxXXXXXXXXXx --tenant XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX

```

3. **  Create a storage account**

```sh

az storage account create --name myStorageAccountName --resource-group myResourceGroupName --kind <KIND> --sku Standard_LRS --location westus

```

**Example:**

```sh
az storage account create --name mystorageaccountca --resource-group Security-TESTs --kind StorageV2 --sku Standard_LRS --location southafricanorth

```

4. **  Get resource keys to authenticate to the Azure storage account.**

```sh

az storage account keys list --resource-group myResourceGroupName --account-name myStorageAccountName

```

**Example:**

```sh

az storage account keys list --resource-group Security-TESTs  --account-name mystorageaccountca

```


</details>

### Result
🎊 **Congratulations!** You have successfully created Azure storage account.

💡 **Learning Resources:**
- [Cleanup & troubleshoot service principals]( https://learn.microsoft.com/en-us/cli/azure/azure-cli-sp-tutorial-8)


**Navigation:**
- [< Previous Module 2 - Securing Networks](../module-2/README.md)
- [Next Module 4 - Securing Data at Rest >](../module-4/README.md)
