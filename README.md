
## Deploy Postgres Flexible Server in Azure

### Login to Azure using the CLI

```
az Login`
```

Use `az account show` to check the subscription context.


### Init, Apply, and Plan, to deploy resources using Terraform


Navigate to the terraform folder and run the following commands.

```terraform
./terraform.exe init`

./terraform.exe plan`

./terraform.exe apply`
```

### Cleanup Resources

```
./terraform.exe destroy`
```

#### Notes

Installed Terraform version: hashicorp/azurerm v2.87.0 