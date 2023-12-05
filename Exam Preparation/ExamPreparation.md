# Terraform Providers

A provider is responsible for understanding API interactions and exposing resources. 

Most of the available providers correspond to one cloud or on-premises infrastructure platform, and offer resource types that correspond to each of the features of that platform. 

You can explicitly set a specifc version of the provider within the provider block. 

To upgrade to the latest acceptable version of each provider

    terraform init -upgrade

You can have multiple provider instance with the help of alias 

    provider "aws" {
        region = "us-east-1"
    }
    provider "aws" {
        alias = "west"
        region = "us-west-2"
    }

**Terraform Init** 

The provider block without alias set is known as the default provider configuration. When an alias is set, it creates an additional provider configuration. 

Terraform init coommand is used to initalize a working directory containing Terraform configuration files. 

During init, the configuration is searched for module blocks, and the source code for referenced modules is retrieved from the locations given in their source arguments. 

Terraform must initialize the provider before it can be used. 

Initalization downloads and installs the providers plugin so that it can later be executed. It will not create any sample files like example.tf. 

**Terraform Plan**
The terraform plan command is used to create an execution plan. 

It will not modify things in infrastructure. 

Terraform performs a refresh, unless explicitly disabled and then determines what actions are necessary to achieve the desired state specified in the configuration files. 

This command is convenient way to check whether the execution plan for a set of changes matches your expectations without making any changes to real resources or to the state. 

**Terraform Apply** 
The terraform apply command is used to apply the changes required to reach the desired state of the configuration. 

Terraform apply will also write data to the terraform.tfstate file. 

Once apply is completed, resources are immediately available. 

**Terraform Refresh** 

The terraform refresh command is used to reconcile the state Terraform knows about (via its state file) with the real-world infrastructure. 

This does not modify infrastructure but does modify the state file. 

**Terraform Destroy** 

Is used to destroy the Terrafrom-managed infrastructure. 

terraform destroy command is not the only command through which infrastructure can be destroyed. 

Removing resource from configuration file

**Terraform Format** 

The terraform format command is used to rewrite Terraform configuration files to a canonical format and style. 

**Terraform Validate** 

Validates the configuration files in a directory. 

Validate runs checks that verify whether a configuration is syntactically valid and thus primarily useful for general verification of resuable modules, including the correctness of attribute names and value types. 

It is safe to run this command automatically for example as a post-save check in a text editor or as a test step for a resuable module in a CI system. It can run before terraform plan. 

Validation requires an initialized working directory with any referenced plugins and modules installed. 

**Terraform Provisioners** 

Provisioners can be used to model specific actions on the local machine or on a remote machine in order to prepare servers or other infrastructure objects for service. 

Provisioners should only be used as a last resort. For most common situations, there are better 

    resource "aws_instance" "web" {
        provisioner "local-exec" {
            command = "echo The servers IP address is ${self.private_ip}"
        }
    }

