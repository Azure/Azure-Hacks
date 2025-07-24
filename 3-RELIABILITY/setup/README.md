# Setut

For the Reliability Hack, we will use the same terraform template as the ARCHITECTURE Hack, but with a small modification to begin with.

Navigate through the [template library](https://azure.github.io/awesome-azd/) and find a suitable template to start.

The application should utilize the following Azure resources:

- [**Azure App Services**](https://docs.microsoft.com/azure/app-service/) to host the web frontend and API backend of the application.
- [**Azure Cosmos DB API for MongoDB**](https://docs.microsoft.com/azure/cosmos-db/mongodb/mongodb-introduction) for storage.
- [**Azure Monitor**](https://docs.microsoft.com/azure/azure-monitor/) for monitoring and logging.
- [**Azure Key Vault**](https://docs.microsoft.com/azure/key-vault/) for securing secrets.

Use the "React Web App with Python API and MongoDB - Terraform" Template.

After you have the used **azd init -t todo-python-mongo-terraform**, let's modify the cosmos configuration before we deploy. (don't forget to login first **azd auth login**)

Open the folder where the **cosmos.tf** file is located (``/infra/modules/cosmos``) and open the file. Make the following modifications:

```
  automatic_failover_enabled      = false
  multiple_write_locations_enabled= false

  capabilities {
    name = "EnableMongo"
  }
```

Remove the lifecycle block as it is preventing the capabilities to be modified.

![image](./01_cosmosmodifications.png)

After saving file, you can deploy your app with command **azd up**.

You should have the following resources in your resource group:

![image](./02_resources.png)


✅ **Congratulations** You deploy the TODO Application with Cosmos DB database non serveless option.