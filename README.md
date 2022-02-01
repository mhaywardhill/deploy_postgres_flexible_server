## Deploy Postgres Flexible Server in Azure

### Project Overview

![Azure diagram](/diagram/postgres_flexible_diagram.png)  

### Deploy resources

Login to Azure using the CLI
```
az Login
```

Use `az account show` to check the subscription context.

#### Set environment variables

The project prefix is used to name all the resources.

```variables
export TF_VAR_project_name="<project prefix>"

export TF_VAR_vm_username="<vm admin username>" 

export TF_VAR_my_public_ip=$(curl -s http://whatismyip.akamai.com/)

HISTCONTROL=ignoreboth
 export TF_VAR_db_username="<admin username>"
 export TF_VAR_db_password="<password>"
```

####  Init, Apply, and Plan, to deploy resources using Terraform


Navigate to the terraform folder and run the following commands.

```terraform
./terraform init

./terraform plan

./terraform apply
```
####  Connect to the VM

```
export vm_public_ip_addr=$(./terraform output -raw vm_public_ip_address) 

ssh $vm_public_ip_addr
```



####  Cleanup Resources

```
./terraform destroy
```

#### Notes

Installed Terraform version: hashicorp/azurerm v2.87.0 
