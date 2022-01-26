
## Deploy Postgres Flexible Server in Azure

### Login to Azure using the CLI

```
az Login
```

Use `az account show` to check the subscription context.

### Set environment variables

The project prefix is used to name all the resources.

```variables
export TF_VAR_project_name="<project prefix>"
```

### Init, Apply, and Plan, to deploy resources using Terraform


Navigate to the terraform folder and run the following commands.

```terraform
./terraform init

./terraform plan

./terraform apply
```

### Cleanup Resources

```
./terraform destroy
```

#### Notes

Installed Terraform version: hashicorp/azurerm v2.87.0 