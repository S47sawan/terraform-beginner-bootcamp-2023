# Terraform Beginner Bootcamp 2023 - Week 0

## Table of Contents
- [Terraform Beginner Bootcamp 2023- Week 0](#terraform-beginner-bootcamp-2023--week-0)
  - [Table of Content](#table-of-content)
  - [Semantic Versioning](#semantic-versioning)
  - [Refactor terraform cli](#refactor-terraform-cli)
  - [How to check the OS version in Linux](#how-to-check-the-os-version-in-linux)
  - [Change file permissions in Linux](#change-file-permissions-in-linux)
  - [Github Lifecycle (Before,Init,Command)](#github-lifecycle-beforeinitcommand)
  - [Working ENV VARS](#working-env-vars)
    - [SETTING AND UNSETTING Env Vars](#setting-and-unsetting-env-vars)
    - [Printing Env Vars](#printing-env-vars)
    - [Scoping of Env Vars](#scoping-of-env-vars)
    - [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
  - [AWS CLI Installation](#aws-cli-installation)
  - [Terraform Basics](#terraform-basics)
    - [Terraform registry](#terraform-registry)
    - [Terraform Console](#terraform-console)
    - [Terraform Lock Files](#terraform-lock-files)
    - [Terraform State Files](#terraform-state-files)
    - [Terraform Directories](#terraform-directories)
  - [Terraform Cloud as the remote backend for statefile](#terraform-cloud-as-the-remote-backend-for-statefile)
  - [Adding alias to bash profile](#adding-alias-to-bash-profile)
    - [Automate set\_tf using bash script](#automate-set_tf-using-bash-script)


## Semantic Versioning

In this project _Semantic Versioning_ will be implemented for tagging purposes.

_For further reading click on this link_ [semver.org](https://semver.org/)


Given a version number MAJOR.MINOR.PATCH,`1.0.0`increment the:

-**MAJOR** version when you make incompatible API changes

-**MINOR** version when you add functionality in a backward compatible manner

-**PATCH** version when you make backward compatible bug fixes

## Refactor terraform cli ##
The terraform cli code in .gitpod.yml has been refactored due to legacy gpg keyring warnings that appeared when manually installed.

Refactoring also automed the terraform cli installation.

[Refactor Terraform cli](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## How to check the OS version in Linux ##

Before jumping onto writing bash script for your environment check what distribution of Linux is running.

In your terminal run the following code

````bash
cat/etc/os-release
````
Click here  [Check the OS Version in Linux](https://www.geeksforgeeks.org/how-to-check-the-os-version-in-linux/)for further reference on how to interprate the above output command.

## Change file permissions in Linux ##

The ls command along with its -l option will show you metadata about your Linux files, including the permissions set on the file.

````bash
$ ls -l
````
``````bash
drwxr-xr-x 2 gitpod gitpod   38 Sep 20 20:40 bin
-rw-r--r-- 1 gitpod gitpod 1064 Sep 20 20:34 LICENSE
-rw-r--r-- 1 gitpod gitpod    1 Sep 20 20:34 main.tf
-rw-r--r-- 1 gitpod gitpod 1668 Sep 20 20:58 README.md
``````
For further reference click here : [How to change directory permissions in Linux with chmod](https://www.pluralsight.com/blog/it-ops/linux-file-permissions)

3-refactor-terraform-cli
This is handy for calculating chmod:
[Chmod Calculator](https://chmod-calculator.com/)

## Github Lifecycle (Before,Init,Command) ##

We need to be careful when using the init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

## Working ENV VARS ##

We can list out all **Environment** Variables using the `env` command.

We can filter specific env vars using grep eg `env | grep AWS_`

### SETTING AND UNSETTING Env Vars ###
 
- Set ENV VARS in the terminal using `export HELLO= ='WORLD`
- Unset ENV VARS in the terminal using `unset HELLO`
- We can set an env var temporarily when just running a command

````sh
HELLO= 'world' ./bin/print_message
````
-Within a bash script we can set env without writing export eg.

````sh
#! usr/bin/env bash

HELLO= 'world'

echo $ HELLO

````
### Printing Env Vars ###

We can print an env var using echo eg `echo $HELLO`

### Scoping of Env Vars ###

When you open up new bash terminals in VSCode it will not be aware of env vars that you have set in another windoe.

If you want Env Vars to persist across all future bash terminals that are open you need to set env vars in hyour bash profile. eg. `bash_profile`

### Persisting Env Vars in Gitpod ###
We can _persist env vars into gitpod_ by storing them in ***Gitpod Secrets Storage***

````sh
gp env HELLO='world'

````
All future workspaces launched will set the env vars for all bash terminald opened in workspaces.

You can also set en vars in the '.gitpod.yml' but this can only contain non-sensitive Env Vars.

## AWS CLI Installation ##

[Environment variables to configure the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

AWS CLI is installed for the project via the bash script [`./bin/imstall_aws_cli.sh`](./bin/install_aws_cli.sh)

Get the aws cli credentials from the console in AWS IAM.

[Installing aws cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

To check if AWS credentials is configured correctly run the command below in your terminal
````bash
 aws sts get-caller-identity
````
If it is successful Json message shown below will be returned

````bash
{
    "UserId": "AIDA4RM5RIMWRY6UEPQGY",
    "Account": "872018198609",
    "Arn": "arn:aws:iam::872018198609:user/Smihah-Awan"
}
````
To unset the **ENV VARS** in the aws cli simply use the `unset` command followed by the variables.

##  Terraform Basics  

### Terraform registry ###

Terraform Registry is a centralized online repository provided by HashiCorp that serves as a hub for sharing, discovering, and accessing _Terraform modules and providers_. 

It allows Terraform users to easily find and use _pre-built infrastructure code and resources_, **promoting code reusability** and **simplifying infrastructure management**.

 :white_check_mark: Terraform providers : they are plugins that enable Terraform to interact with external services and APIs.
  [Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/latest)

 :white_check_mark: Terraform Modules : these can be defined as reuseable templates that encapsulate related resources and configurations making it easier to manage and scale Iac projects.
  [registry.terraform.io] (https://registry.terraform.io/providers/hashicorp/random/latest/docs)

### Terraform Console ###

Terraform console is an _interactive command-line tool_ provided by Terraform that allows users to
- evaluate expressions
- query information about resources 
- experiment with the Terraform language

There are three main commands that are used to interact with terraform:
- **Terraform Init** : initializes a Terraform project by _downloading provider plugins_ and setting up the working directory for managing infrastructure as code.
- **Terraform plan** : _generates an execution plan_ that previews changes to infrastructure resources before applying them.
- **Terraform apply** : _applies the changes defined_ in your Terraform configuration to create or modify infrastructure resources. To automate apply apend `-auto-approve` to 
   `Terraform apply` in your terminal.
- **Terraform destroy** : This command is used to destroy resources in the AWS CONSOLE. 
      :warning: If resources have been deployed in the AWS CONSOLE using terraform , **NEVER** delete them manually from the AWS CONSOLE, instead, run the `terraform destroy` command in the VScode/gitpod terminal.

### Terraform Lock Files ###

 `.terraform.lock.hcl`  contains the locked versioning for the providers or modules that should be used with this project.

 The terraform Lock Fil should be committed to version control system e.g github

### Terraform State Files ###
 
 :warning:  `terraform.tfstate`  file **should NOT** be commited to your github
 
 :warning: DO NOT lose this file you will lose your infrustrature

`terraform.tfstate` keeps track of the changes implemeted to the Infrustracture by comparing the  **Desired state** (what you specified in your configuration) to the **current state** (what is actually deployed in your cloud or infrastructure environment). 

### Terraform Directories ###

`.terraform` directory contains binaries of terraforn providers.

## Terraform Cloud as the remote backend for statefile ##

In this project rather than using s3 as the remote backend I have used [Terraform Cloud](https://developer.hashicorp.com/terraform/cloud-docs).

- Implement the code below in the main.tf file to set the backend

````json
  cloud {
      organization = "cloudgirl"

      workspaces {
        name = "terra-house-1"
      
      }
    }
````
- Next run `terraform login` in the terminal

- You will be prompted for a token which you enter into the terminal. 

- After successful login, run `terraform init` to initial terrform cloud as your remote backend.

:warning: should you encounter error whilsts entering the token into your terminal, create the ` touch /home/gitpod/.terraform.d/credentials.tfrc.json` folder.
          
          Next  `open /home/gitpod/.terraform.d/credentials.tfrc.json` and check that toekn is set here. 

          ````json
            {
              "credentials": {
                "app.terraform.io": {
                  "token": "your-terraform-cloud-token" # replace this with your token generate by terraform cloud
                }
              }
            }
          ````
 
## Adding alias to bash profile ##

Rather than having to type the full word "terraform" into the terminal, we can use alias for terraform `alias tf=terraform` in the ~/.bash_profile. In the terminal 

step 1: run `open ~/.bash_profile` in our bash terminal

step 2: This will open a bash file to which at the end apend or add `alias tf=terraform`. Save the file.

step 3: Reload the bash for the changes to take effect `source ~/.bash_profile`

step 4: type `tf` in your terminal to check that changes have been apply and your ready to go!!

### Automate set_tf using bash script ##

step 1: Automate the process by creating a bash-script. As each time you reload your workspace in gitpod, the alias will be set 
        via the .gitpod.yml file.

step 2: Using chatgpt generate a bash file that will set the alias in the bash_profile.

step 3: To check the bash script run it in the terminal but **📝do not forget to change permissions on bashscript before running**

step 4 : `chmod u+x set_tf_alias`

step 5 : after changing permission run the file in the terminal. :tada: your tf alias is now set!!

