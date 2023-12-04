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

    "module/<MODULE NAME>.<OUTPUT NAME>"
    [module.sgmodule.sg_id]


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
    terraform destroy -auto-approve

# Terraform Registry

[Terraform-Registry](https://registry.terraform.io/) 

Is a repository of modules written by the terraform community. 
The registry can help you get started with Terraform more quickly. 

**Verified Modules in Terraform Registry** 
Within Terraform Registry, you can find verified modules that are maintained by various third party vendors. These modules are available for various resources like AWS VPC, RDS, ELB, and others. 

Verified modules are reviewed by HashiCorp and actively maintained by contributors to stay up-to-date and compatible with both Terraform and their respective providers. 

The blue verification badge appears next to modules that are verified.

Module verification is currently a manual process restricted to a small group of trusted HashiCorp partners. 

[Module-sourcecode](https://github.com/terraform-aws-modules/terraform-aws-ec2-instance/tree/v5.5.0/examples/complete)

    module "ec2cluster" {
    source = "terraform-aws-modules/ec2-instance/aws"
    version = "~> 2.0"
    name = "my-cluster"
    instance_count = 1
    ami = "ami-1341324"
    instance_type = "t2.micro"
    subnet_id = "ami-141253534"
    tags = {
        Terraform = "true"
        Environment = "dev"
        }
    }  

# Requirements for Publishing Modules in Terraform Registry
| Requirement | Description |
| --- | --- |
| Github | The module must be on GitHub and must be a public repo. This is only a requirement for the public registry |
| Named | Module repositories must the three-part name format terraform-<PROVIDER>=<NAME> |
| Respository Description | The GitHub repository description is used to populate the short description of the module |
| Standard module structure | The module must adhere to the standard module structure |
| x.y.z tags for releases | The registry uses tags to identify module versions. Release tag names must be a semantic version, which can optionally be prefixed with a v. For example, v1.0.4 and 0.9.2 |

**Standard Module Structure** 
The standard module structure is a file and directory layout that is recommended for resuable modules distributed in separate repositories 

Minimal module structure 

* README.md
* main.tf
* variables.tf
* outputs.tf

Complete module structure 

* README.md
* main.tf
* variables.tf
* outputs.tf
* modules/
    * nestedA/
        * README.md
        * main.tf
        * variables.tf
        * outputs.tf
    * nestedB/
* examples/
    * exampleA/
        * main.tf
    * exampleB/

# Terraform Workspace

Terraform allows us to have multiple workspaces, with each of the workspaces we can have different set of environment variables associated 

Each workspace can have a different set of environment variables 

    terraform workspace 
    terraform workspace show #display current workspace
    terraform workspace list 
    terraform workspace select dev #switch to dev workspace
    terraform workspace -h 
    terraform workspace delete
    terraform workspace new 

# Implementing Terraform Workspace

Creating workspaces with different configurations for each workspace

    terraform workspace new dev
    terraform workspace new prod

Setup map variable and lookup function with terraform workspace value as key to select instance_type
Check workspace1.tf

    resource "aws_instance" "myec2" {
        ami = ami-04823729c75214919
        instance_type = lookup(var.instance_type,terraform.workspace) 
    }

    variable "instance_type" {
        type = "map"
        default = {
            default = "t2.nano"
            dev = "t2.micro"
            prod = "t2.large"
        }
    }

**terraform.tfstate.d**
This directory contains separate state files for each workspace accordingly

    terraform.tfstate
