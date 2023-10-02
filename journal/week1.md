# Terraform Beginner Bootcamp 2023 - Week 1 🏗️


## Root Module structure.

A standard module structure refers to the organization and layout of files and directories within a module as shown below:

                                                        ````
                                                        PROJECT_ROOT/
                                                        ├── Provider.tf
                                                        ├── main.tf
                                                        ├── outputs.tf
                                                        ├── variables.tf
                                                        ├── terraform.tfvars
                                                        └── README.md
                                                        ````
### File functions in the root directory:

▶️ **main.tf** : Define the primary infrastructure resources and their configurations in this file. 

▶️ **provider.tf** : Configures and specifies the details of the provider (e.g., AWS) to be used by Terraform for managing infrastructure.

▶️ **outputs.tf** : Define the outputs of your Terraform configuration here.

▶️ **varibles.tf** : This file is used to declare input variables for your Terraform configuration.

▶️ **README.md** : This file contains a description of the module and what it should be used for.

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

