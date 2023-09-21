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

