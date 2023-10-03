
# Terraform Beginner Bootcamp 2023 - Week 1 🏗️


## [Root Module structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

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

▶️ **provider.tf** : Configures and specifies the details of the provider to be used by Terraform for managing 
     infrastructure.

▶️ **outputs.tf** : Define the outputs of your Terraform configuration here.

▶️ **varibles.tf** : This file is used to declare input variables for your Terraform configuration.

▶️ **README.md** : This file contains a description of the module and what it should be used for.

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Setting Input Terraform Cloud (Backend) Variables ##
 
In terraform cloud we can set two types of variables:

:arrow_forward: **Environment variables**:  These are variables that are set in bash terminal eg AWS credentials. This variables can be set to sensitive.

:arrow_forward: **Terraform variables**: These are variables that can be changed and are usually set in the .tfvars file.

### Setting run-specific variables ##

 You can set run-specific Terraform variable values by using:
  
#### -var flag ####
````bash
terraform apply -var="key=value"
````

    example

````bash
terraform apply -var="image_id=ami-abc123"
 ````
  

#### -var-file flag ####

      In Terraform, the `-var-file` flag is used to specify an external variable file that contains values for variables used in your Terraform configuration. Here's a description of the `-var-file="testing.tfvars"` flag:

      1. `-var-file:` This is a command-line option in Terraform. It is used to indicate that you want to provide variable values from an external file rather than defining them directly in your Terraform configuration files. The `-var-file` flag allows you to keep sensitive or environment-specific values separate from your main configuration.

      2. **"testing.tfvars":** This part of the flag specifies the path to the external variable file. In this example, "testing.tfvars" is the name of the file that contains the variable values. The file should be located in the same directory as your Terraform configuration files unless you specify an absolute path.

    Here's an example of how you might use the `-var-file` flag in a Terraform command:

````bash
    terraform apply -var-file="testing.tfvars"
````

    In this example, when you run the `terraform apply` command, Terraform will read the variable values from the "testing.tfvars" file and use them to override any corresponding variables defined in your Terraform configuration files. This is particularly useful for separating configuration values, such as API keys or secret credentials, from the main configuration to enhance security and maintainability.

#### TF_VAR_

Creating local environment variables prefixed with `TF_VAR_`.
    
For example, if you declare a variable called replicas in your configuration, you could create a local environment variable called `TF_VAR_replicas` and set it to a particular value

### Loading variables from .tfvars file.

`terraform.tfvars` is the file where you assign values to the declared variables. It's where you provide the actual values for the variables you've defined in variables.tf 

### Auto loading variables using auto.tfvars file.

In Terraform, an `auto.tfvars` file serves as an automatic variable definitions file. It is automatically loaded by Terraform to provide default values for variables in your configuration. Here's how it functions:

1. **Automatic Loading**: When you run `terraform apply` or `terraform plan` without specifying explicit values for input variables, Terraform will look for an `auto.tfvars` file in the same directory as your Terraform configuration files.

2. **Variable Definitions**: Inside the `auto.tfvars` file, you can define values for your variables. These values will serve as defaults that Terraform uses when you don't provide values through command-line flags or other means.

3. **Fallback Defaults**: If a variable is defined in `auto.tfvars`, and you don't explicitly provide a value when running Terraform commands, the value from `auto.tfvars` will be used as the default.

Here's an example of an `auto.tfvars` file:

```hcl
region = "us-west-2"
instance_type = "t2.micro"
```

In this example, if you have variables named `region` and `instance_type` in your Terraform configuration, and you don't provide values for them during `terraform apply`, Terraform will use the values specified in `auto.tfvars` as defaults.

### [Variable Definition Precedence](https://developer.hashicorp.com/terraform/language/values/variables)

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

 - Environment variables
 - The terraform.tfvars file, if present.
 - The terraform.tfvars.json file, if present.
 - Any *.auto.tfvars or *.auto.tfvars.json files, 
   processed in lexical order of their filenames.
 - Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by a  
    Terraform Cloud workspace.)

## Dealing with Configuration Drift

### [Fixing Missing Resources with Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
    
🪣 [Importing AWS s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)

 Terraform state file compares the current state with the desired state. Should it detect that a resource exists in the aws console but not in the state file, it will throw an error.

  ✅ To correct this drift, **import** the missing resource into the state file.

````bash
   terraform import aws_s3_bucket.bucket bucket-name
````
  🗒️ Before importing a resource into state file, the code block for the resource **must exist** in terraform.

### Fix Manual Configuration

This situation arises when a resource is manually deleted in the AWS Console. 

In case the resource exists in the state file but not in AWS Console (real world)

In the example below `terraform plan ` was run in the terminal.

Terraform automatically detected a drift form the current state, hence it went ahead and planned the deployment of s3 bucket in the AWS console.

🔴 is used to indicate terraform drift detection and create.



````bash
Terraform v1.5.7
on linux_amd64
Initializing plugins and modules...
aws_s3_bucket.website_bucket: Refreshing state... [id=d00fwzo6nqdah7l7w5cs389wqlwi9qmc]
aws_s3_bucket.website_bucket: Drift detected (delete) 🔴

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  + create 🔴

Terraform will perform the following actions:

  # aws_s3_bucket.website_bucket will be created
  + resource "aws_s3_bucket" "website_bucket" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = "d00fwzo6nqdah7l7w5cs389wqlwi9qmc"
      + bucket_domain_name          = (known after apply)
      + bucket_prefix               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + tags                        = {
          + "UserUUID" = "var.user_uuid"

````