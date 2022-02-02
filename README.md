## Deploy Postgres Flexible Server in Azure

### Project Overview

I use this project to create a Postgres test environment in Azure using Terraform. I execute the commands from a Linux terminal on Windows (Ubuntu on WSL).
 
The environment variable TF_VAR_project_name and the Terraform variable environment_name (hardcoded in the input.tf file) are used to name the resource group and resources.
 
I have selected Private access (VNET Integration) for the connectivity method, so the Postgres server is deployed in a delegated subnet. For database access, I have deployed a Ubuntu virtual machine in a subnet in the same VNET.
 
To keep the cost down, the starting compute tier for the Postgres server is Burstable, and the virtual machine size is B1s. The Postgres server can be stopped when not in use to save costs, one of the advantages over Postgres single server.
 
The server parameters for the Postgres server are configured in the input.tf for the PostgreSQL terraform module using a key-value list function. I plan to revisit the server parameters to add best practices; for now, the log_line_prefix is changed.

Below depicts on a high-level the resources deployed.


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
###  Connect to the VM

```
export vm_public_ip_addr=$(./terraform output -raw vm_public_ip_address) 

ssh $vm_public_ip_addr
```



###  Cleanup Resources

```
./terraform destroy
```


### Prerequisites

Download the Linux Terraform binary and copy to terraform environment folder, for example, environments/test.

The project has been tested with Terraform version: hashicorp/azurerm v2.87.0 

https://www.terraform.io/downloads

Install the Azure CLI

https://docs.microsoft.com/en-us/cli/azure/install-azure-cli

Install Git

```
sudo apt install git
```