**Typical Challenge**
Resource 2 might be dependent on Resource 1
For an elastic IP to be added to a security group, the elastic IP would have to be created first so that the ip address can be fetched and included as a rule in the security group. 

**Basics of a Resource attributes**
Each resource has its associated set of attributes 
Attributes are the fields in a resource that hold the values that end up in state 
Example: EC2 has arn, instance_state, private_dns .... 

Terraform allows us to reference the attribute of one resouce to be used in a different resource
example: elastic ip, attibute public_ip= 57.72.52.72 
security group, cidr_blocks= [${aws_eip.myeip.public_ip}/32]

running terraform plan the resource that will fetch the specifc attribute of another resource will say "(known after apply)"

**Output Values**
Output values make information about your infrastructure available on the command line, and can expose information for other Terraform configurations to use. 
Output values defined in Project A can be referenced from code in Project B as well. Even if they are in different Github repositories
Project B can fetch the output values from the state file of Project A

**Terraform Variables** 

can create a central source from which we can import the values from.  

Variables.tf is where you map the hardcode values for the variables. 

Variables in Terraform can be assigned values in multiple ways. 

Some of these include: 
1. Environment Variables
2. Command Line Flags  
3. From a File
4. Variable Defaults

**Environment Variables**

Windows:

                setx TF_VAR_instancetype m5.large 
                echo %TF_VAR_instancetype% 
        #will display value in a new terminal not in the same terminal where you set the environment variable

Linux:

                export TF_VAR_instancetype="t2.nano"
                echo $TF_VAR_instancetype 
        #dont need to open a new termianl to view the value of the variable


**Command Line Flags**

        terraform plan -var="instancetype=t2.small"

**From a File** 


terraform.tfvars takes priority over default values specified in variables.tf 

Use the same naming convention "terraform.tfvars" or else you will need to specify the file name in the CLI. 

    terraform plan -var-file="custom.tfvars"

**Variable Defaults** 

variables.tf 

        variable instance_type{
            default="t2.micro"
        }


**Type Contraints** 

The type argument in a variable block allows you to restrict the type of value that will be accepted as the value for a variable. 

If no type constraint is set then a value of any type is accepted. 

    variable "image_id"{
      type = string
    }














