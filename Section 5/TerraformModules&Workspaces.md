# DRY Principle

Don't Repeat Yourself (DRY) is a principle of software development aimed at reducing repitition of software patterns

Reduce the repititive patterns in software development. 

**Centralized Structure**
We can centralize terraform resources and can call out from TF files whenever required 
Module based approach 

mod_ec2.tf

    resource "aws_instance" "myweb" {
      ami = "ami-adfsdfsadfas"
      instance_type = "t2.micro"
      security_groups = ["default"]
      key_name = "remotepractical"
    }

ec2_web.tf

    module "myec2" {
        source = "../../modules/ec2"
    }

# Implementing EC2 module

Create resource file with configurations and then create module with source pointing to the resource file.

Install the modules in order to use them. 

    terraform init

# Variables and Terraform Modules
A common need on infrastructure management is to build  environments like dev, test, staging, production with similar set up but keeping environment variables different.

You will need to use different modules for different environments as, resources are direct replicas of code in the modules.

Using variables faciliates the process of updating resources with new values instead of manually having to update every hardcoded value in every resource block.

Can use variables to avoid hardcoding values in the module files and set a default value 

Default values can be overidden by values that are explciity stated. 

Hardcoded values can not be overidden

    resource "aws_instance" "myec2" {
      ami = ami-04823729c75214919
      instance_type = var.instance_type #default value
    }

    module "ec2module" {
    source = "../../modules/ec2"
    instance_type = "t2.large" #value explicitly stated, trumps default variable value
    }

# Using Locals with Modules

Variables can be overridden in the module file 

locals can prevent variables from being overridden

example:

    from_port = local.app_port

# Referencing Module Outputs

In a parent module, outputs of child modules are available in expressions as module.

    <MODULE NAME>.<OUTPUT NAME>


    module "sgmodule" {
      source = "../../modules/sg"
    }
    resource "aws_instance" "myec2" {
      ami = ami-04823729c75214919
      instance_type = "t2.micro"
      vpc_security_group_ids = [module.sgmodule.sg_id] #integrates the newly created security group to the new ec2, by pointing to the output value in the resource file
    }

    terraform init
    terraform plan
    terraform apply -auto-approve