# Typical Challenge
Resource 2 might be dependent on Resource 1
For an elastic IP to be added to a security group, the elastic IP would have to be created first so that the ip address can be fetched and included as a rule in the security group. 

# Basics of a Resource attributes
Each resource has its associated set of attributes 
Attributes are the fields in a resource that hold the values that end up in state 
Example: EC2 has arn, instance_state, private_dns .... 

Terraform allows us to reference the attribute of one resouce to be used in a different resource
example: elastic ip, attibute public_ip= 57.72.52.72 
security group, cidr_blocks= [${aws_eip.myeip.public_ip}/32]

running terraform plan the resource that will fetch the specifc attribute of another resource will say "(known after apply)"

# Output Values
Output values make information about your infrastructure available on the command line, and can expose information for other Terraform configurations to use. 
Output values defined in Project A can be referenced from code in Project B as well. Even if they are in different Github repositories
Project B can fetch the output values from the state file of Project A

# Terraform Variables

can create a central source from which we can import the values from.  

Variables.tf is where you map the hardcode values for the variables. 

Variables in Terraform can be assigned values in multiple ways. 

Some of these include: 
1. Environment Variables
2. Command Line Flags  
3. From a File
4. Variable Defaults

# Environment Variables

Windows:

    setx TF_VAR_instancetype m5.large 
    echo %TF_VAR_instancetype% 
    #will display value in a new terminal not in the same terminal where you set the environment variable

Linux:

    export TF_VAR_instancetype="t2.nano"
    echo $TF_VAR_instancetype 
    #doesn't need to open a new terminal to view the value of the variable


# Command Line Flags

        terraform plan -var="instancetype=t2.small"

# From a File


terraform.tfvars takes priority over default values specified in variables.tf 

Use the same naming convention "terraform.tfvars" or else you will need to specify the file name in the CLI. 

    terraform plan -var-file="custom.tfvars"

# Variable Defaults

variables.tf 

    variable instance_type{
        default="t2.micro"
    }


# Type Contraints

The type argument in a variable block allows you to restrict the type of value that will be accepted as the value for a variable. 

If no type constraint is set then a value of any type is accepted. 

    variable "image_id"{
      type = string
    }

# Used case example

check ec2_datatype.tf

company makes you use your number only ID to provision instances

variable.tf

    variable "instance_name" {
      type=number
      }

terraform.tfvars

    instance_name="john-123"

# Overview of DataTypes

| Type Keywords | Description |
| - | - |
| string | Sequence of unicode characters representing some text, like "hello" |
| list | Sequential list of values identified by their position. Starts with 0. ["0","1","2"] |
| map | group of values identified by named labels (key, value), {name ="Martin", age=25} |
| number | 200 |

# Fetching Data from Maps and Lists in a Variable

for maps reference the variable and the key of the value you want:

    instance_type = var.types["us-west-2"] #returns t2.nano

    variable "types" {
      type=map
      default = {
        us-east-1 = "t2.micro"
        us-west-2 = "t2.nano" 
        ap-south-1 = "t2.small"
      }
    }

for list reference the variable and position number of the value you want

    instance_type = var.list[0] #returns m5.large
  
    variable "list" {
      type = list
      default = ["m5.large","m5.xlarge","t2.medium"]
    }

# Overview of Count Parameter

The count parameter on resources can simplify configurations and let you scale resources by simply incrementing a number.

lets assume, you need to create two EC2 instances. One of the common approach is to define two separate resource blocks for aws_instance. This will make code longer.

With count parameter, we can simplify specify the count value and the resource can be scaled accordingly

    resource "aws_instance" "instance-1"{
      ami = "ami-1358923841f"
      instance_type = "t2.micro"
      count = 5 #creates 5 instances
      }

# Count Index

In resource blocks where count is set, an additional count object is available in expressions, so you can modify the configurations of each instance.

This object has one attribute:

count.index --The distinct index number (starting with 0) corresponding to this instance

    #returns 5 loadblancers, with names: loadbalancer.(0-4)
    resource "aws_iam_user" "lb" {
      name = "loadbalancer.${count.index}" 
      count = 5
      path = "/system/"
    }

    #iterates through list of names
    variable "elb_names" {
      type =list
      default = ["dev-loadbalancer", "stage-loadbalancer", "prod-loadbalancer"]

    resource "aws_iam_user" "lb" {
      name = var.elb_names[count.index]
      count = 3
      path = "/system/"
    }

# Conditional Expressions

condition ?(then) true_value :(else) false_value 

**Variable Value specified in terraform.tfvars**

istest = true

Ex: count = var.istest == true ? 3 : 0 
since istest is true, terraform will create 3 instances from that block else none are created

# Local Values

https://developer.hashicorp.com/terraform/language/values/locals

A local value assigns a name to an expression, allowing it to be used multiple times within a module without repeating it

Ex: creates local value common_tags which can be attached to instance block
tags = local.common_tags

        locals {
          common_tags = {
            Owner = "DevOps Team"
            service = "backend"
            }
          }

Local Values can be used for multiple different use-cases like having a conditional expression 

    locals{
      name_prefix = '${var.name != "" ? var.name : var.default}
    } #creates local value name_prefix that checks if var.name is empty if so points to var.name if not then uses var.default
    #use concat function

Local values can be helpful to avoid repeating the same values or expressions multiple times in a condition

If overused they can also make a configuration hard to read by future maintainers by hiding the actual values used

Use local values only in moderation, in situations where a single value or result used in many places and that value is likely to be changed in the future

# Terraform Functions

The Terraform language includes a number of built-in functions that you can use to transform and combine values. 
The general syntax for function calls is a function name followed by comma-separated arugements in parentheses:

function(arguement1, arguement2)
Ex: max(5,12,9)
12

The Terraform language does not support user-defined functions, and so only the functions built in to the language are available for use

https://developer.hashicorp.com/terraform/language/functions

* Numeric
* String
* Collection
* Encoding
* Filesystem
* Date and Time
* Hash and Cryptio
* IP Network
* Type Conversion

to test terraform fucntions:

    terraform console

# Data Sources
Data sources allow data to be fetched or computed for use elsewhere in Terraform Configuration

https://developer.hashicorp.com/terraform/language/data-sources

Ex:

    data "aws_ami" "app_ami" {
      most_recent = true
      #specifies most recent ami from amazon
      owners = ["amazon"]

      filter {
        name = "name"
        #filters to amazon linux 2 ami
        values = ["amzn2-ami-hvm*"]
    }
}

# Debugging in Terraform 
Terraform has detailed logs which can be enabled by setting the TF_LOG environment variable to any value

You can set TF_LOG to one of the log levels: TRACE, DEBUG, INFO, WARN, or ERROR to change the verbosity of the logs

    export TF_LOG=TRACE
    export TF_LOG_PATH=/tmp/terraform-crash.log #store logs in a separate file

TRACE is the most verbose and it is the default if TF_LOG is set to something other than a log level name

# Terraform Format 
Terraform fmt command is used to rewrite Terraform Configuration files to take care of the overall formatting

    terraform fmt 

# Terraform Validate 
checks whether a configuration is syntactically valid. 
It can check various aspects including unsupported arguments, undeclared variables and others.

# Load Order and Semantics 
Terraform generally loads all the configuration files within the directory specified in alphabetical order. 
The files loaded must end in either .tf or .tf.json to specify the format that is in use. 

Best practice to separate configurations in to separate files

# Dynamic Blocks 
In many use-cases there are repeatable nested blocks that needs to be defined.

Dynamic blocks allows us to dynamically construct repeatable nested blocks which is supported inside resource, data, provider, and provisioner blocks

**Iterators**
The iterators argument (optional) sets the name of a temporary variable that represents the current element of the complex value

    iterator = port

if omitted, the name of the variable defaults to the label of the dynamic block ("ingress" in the dynamic-block.tf)

# Tainting a Resource

Recreate specific resources that could have been manually changed 

    terraform apply -replace="aws_instance.web"

# Splat Expression
allows us to get a list of all the attributes

Ex:

    output "arns" {
      value = aws_iam_user.lb[*].arn #returns list of attributes for all iam users 
    }

# Terraform Graph 
The terraform graph command is used to generate a visual representation of either a configuration or execution plan

The output of terraform graph is in the DOT format, which can easily be converted to an image

    terrform graph > graph.dot

use graphviz.gitlab.io to convert graph.dot to a more visual format


# Saving Terraform Plan to a file 
The generated terraform plan can be saved to a specific path. 
This plan can then be used with terraform apply to be certain that only the changes shown in this plan are applied

    terraform plan -out=demopath #binary file
    terraform apply demopath

# Terraform Output 
The terraform output command is used to extract the value of an output variable from the state file

    terraform output iam_names

Retrieving desired output values
1. Can rerun terraform apply if command is embedded in the file
2. Can get output values by looking at state file **terraform.tfstate** 
3. use terraform output iam_arn

# Terraform Settings 
The special terraform configuration block type is used to configure some behaviors of Terraform itself, such as requiring a minimum Terraform version to apply your configuration.

Terraform settings are gathered together into blocks

The required version setting accepts a version constraint string, which specifies which versions of Terraform can be used with your configuration. 

If the running version of Terraform doesn't match the constraints specified, Terraform will produce an error and exit without taking any further actions

The required_providers blocks specifies all of the providers required by the current module, mapping each local provider name to a source address and a version constraint. 

    terraform {
      required_version = "> 0.12.0"
      required_providers {
        aws = "~> 2.0"
        }
      }
    }


# Large Infrastructure

Be aware of API limits for a provider. 

separate configurations by resourse type to limit api call costs 

ex: ec2.tf, rds.tf, sg.tf, vpc.tf 

1. Everytime you run terraform plan, state is refreshed for every resource.
   
   You can prevent Terraform from querying the current state during operations like Terraform plan.
  
       terraform plan -refresh=false

   "~ update in-place"

2. Specify the Target  
   The -target=resource flag can be used to target a specific resource.
   
   Generally used as a means to operate on isolated portions of very large configurations

        terraform plan -target=ec2
        terraform plan -refresh=false -target=aws_security_group.allow_ssh_conn

   **Production Use**
   Dont use -refresh=false and -target flags in production environments

# Zipmap Function
Constructs a map from a list of keys and a corresponding list of values. 

list of keys
[pineapple, orange, strawberry] 

Combine

list of values
[yellow, orange, red] 

zip map

| zipmap | | 
| --- | --- |
| pineapple=yellow |
| orange=orange |
| strawberry=red |









