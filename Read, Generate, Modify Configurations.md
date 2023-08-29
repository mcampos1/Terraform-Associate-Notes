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
Output values make information about your infratructure available on the command line, and can expose information for other Terraform configurations to use.





















