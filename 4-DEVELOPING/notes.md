# Notes 

### enabling key access against azure storage 
```bash 
az storage account update     --name sa     --resource-group rg     --allow-shared-key-access false

az resource update --ids $(az cosmosdb show --name cosmos --resource-group rg --query "id" --output tsv) --set properties.disableLocalAuth=false
```


