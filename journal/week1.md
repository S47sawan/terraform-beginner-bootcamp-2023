
# Terraform Beginner Bootcamp 2023 - Week 1 🏗️

## Fixing Tags 🛠️

[How To Delete Local and Remote Tags on Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

To delete local tag do:

````sh
 $ git tag -d <tag name>

````
To delete remote tag

````sh
 $ git push --delete origin tagname

````
Checkout the commit that you want to retag. Grab the SHA from your github history.

````sh
git checkout <sha>
git tag <tag version>
git push --tags
git checkout main
````
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
$ terraform apply -var="key=value"
````

    example

````bash
$ terraform apply -var="image_id=ami-abc123"
 ````
  

#### -var-file flag ####

      In Terraform, the `-var-file` flag is used to specify an external variable file that contains values for variables used in your Terraform configuration. Here's a description of the `-var-file="testing.tfvars"` flag:

      1. `-var-file:` This is a command-line option in Terraform. It is used to indicate that you want to provide variable values from an external file rather than defining them directly in your Terraform configuration files. The `-var-file` flag allows you to keep sensitive or environment-specific values separate from your main configuration.

      2. **"testing.tfvars":** This part of the flag specifies the path to the external variable file. In this example, "testing.tfvars" is the name of the file that contains the variable values. The file should be located in the same directory as your Terraform configuration files unless you specify an absolute path.

    Here's an example of how you might use the `-var-file` flag in a Terraform command:

````bash
  $ terraform apply -var-file="testing.tfvars"
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
   $ terraform import aws_s3_bucket.bucket bucket-name
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

## [Terraform Modules](https://developer.hashicorp.com/terraform/language/modules)

A module consists of a collection of .tf and/or .tf.json files kept together in a directory.

Modules are called from within other modules using [module blocks](https://developer.hashicorp.com/terraform/language/modules/syntax).


### [Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

Modules can be imported using the source from various places:

- Terraform Registry
- GitHub
- s3 bucket

for this project the example below is a module block that shows the local path as the source.

````tf
  module "terrahouse_aws" {
    source = "./modules/terrhouse_aws"
  }
````

### Passing Input Variables
We can pass input variables to our module.

The module has to declare the terraform variables in its own varaiabes.tf

````tf
  module "terrahouse_aws" {
    source = "./modules/terrhouse_aws"
    user_uuid = var.user_uuid
    bucket_name = var.bucket_name
  }
````
## Considerations when using CHATGPT to write Terraform

:warning: Large Language Models (LLMs) like ChatGPT might not have access to the most up-to-date Terraform documentation or information, potentially leading to the generation of outdated examples that could no longer be compatible, often impacting providers.

## Working with files in terraform

### [Fileexists function](https://developer.hashicorp.com/terraform/language/functions/fileexists)

`fileexists` determines whether a file exists at a given path.

````tf
  validation {
    condition     = fileexists(var.error_html_filepath)
}
````
### [Filemd5 Function](https://developer.hashicorp.com/terraform/language/functions/filemd5)

````tf
etag   = filemd5(var.error_html_filepath)
````
In Terraform syntax, `etag = filemd5(var.error_html_filepath)` is used to compute the MD5 hash (ETag) of the contents of a file specified by the variable `var.error_html_filepath`. 

- `var.error_html_filepath` is a variable that holds the file path to an HTML file.
- `filemd5()` is a built-in Terraform function used to calculate the MD5 hash of the contents of the specified file.
- `etag` is an attribute that will be assigned the computed MD5 hash.

This syntax is often used when working with AWS S3 or similar services, where the ETag is used to track changes in files for efficient uploads and updates. It allows you to automatically compute the ETag of a file, typically for use in S3 object definitions or other resource configurations where ETags are relevant.



### Path Variable
In terraform there is a special variable called `path` that allows us to reference local paths:
 - path.module = get the path for the current module
 - path.root = get the path for the root module
  
[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references)

````tf
resource "aws_s3_object" "index-html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source ="${path.root}/public/index.html"
  
  etag   = filemd5(var.index_html_filepath)
}
````

## CDN - [Origin Access Control](https://aws.amazon.com/blogs/networking-and-content-delivery/amazon-cloudfront-introduces-origin-access-control-oac/)

 A concept related to content delivery networks (CDNs) and is primarily associated with controlling and securing access to the origin server or the original source of content for a website or web application.

## [Terraform Data Sources](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)

Data sources are a powerful way to fetch information dynamically from external sources and use that data to make your infrastructure configurations more flexible and maintainable.

````bash
    data "aws_caller_identity" "current" {}

````
## [Terraform locals](https://developer.hashicorp.com/terraform/language/values/locals)

 A local value can only be accessed in expressions within the module where it was declared.

 Local values are created by a locals block (plural), but you reference them as attributes on an object named local (singular). :note: Make sure to *leave off the "s" when referencing a local* value.

````tf
locals {
  s3_origin_id = "MyS3Origin"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
   origin_id                = local.s3_origin_id
}
````


## 💡Things to note about this project.

:arrow_forward: Always add `etag   = filemd5(var.error_html_filepath)` to the s3 upload code block for contents to be updated locally as well as s3.

:arrow_forward: *Origin Access Control* (OAC) has been enabled on the CDN. The s3 acts as the origin, hence we do not need to uncheck the BPA on the s3. Rather an s3 policy is used for the cdn to get object from the s3 and delivery the content to end user.


## [The lifecycle Meta-Argument](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

The lifecycle allows when a resource gets updated or created.

tutorial on [Manage resource Lifecycle](https://developer.hashicorp.com/terraform/tutorials/state/resource-lifecycle?utm_offer=ARTICLE_PAGE)

