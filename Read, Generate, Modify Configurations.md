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
        #dont need to open a new termianl to view the value of the variable


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

**Variable value specified in terraform.tfvars**

istest = true

Ex: count = var.istest == true ? 3 : 0 
since istest is true, terraform will create 3 instances from that block else none are created

# Local Values






