## Deploy Postgres Flexible Server in Azure

### Project Overview

I use this project to create a Postgres test environment in Azure using Terraform. I execute the commands from a Linux terminal on Windows (Ubuntu on WSL). 

The environment variable TF_VAR_project_name and the Terraform variable location (hardcoded in the terraform.tfvars file) are used to name the resources.

I have selected Private access (VNET Integration) for the connectivity method, so the Postgres server is deployed in a delegated subnet.


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


Navigate to the terraform environment folder, for example, environments/test and run the following commands.

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



###  Cleanup Resources

```
./terraform destroy
```

### Notes

Installed Terraform version: hashicorp/azurerm v2.87.0 
