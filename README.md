# Terraform Beginner Bootcamp 2023

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

AWS CLI is installed for the project via the bash script [`./bin/imstall_aws_cli.sh`](./bin/install_aws_cli.sh)

[Installing aws cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

To check if AWS credentials is configured correctly run the command below in your terminal
````bash
 aws sts get-caller-identity
````
If it is successful Json message shown below will be returned

````
{
    "UserId": "AIDA4RM5RIMWRY6UEPQGY",
    "Account": "872018198609",
    "Arn": "arn:aws:iam::872018198609:user/Smihah-Awan"
}






