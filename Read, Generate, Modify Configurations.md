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
can create a central source from which we can import the values from. Variables.tf is where you map the hardcode values for the variables. Variables in Terraform can be assigned values in multiple ways. 

Some of these include: 
1. Environment Variables
2. Command Line Flags  
3. From a File
4. Variable Defaults





















