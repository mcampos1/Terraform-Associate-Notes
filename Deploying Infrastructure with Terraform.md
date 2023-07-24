**Authentication and Authorization:**
    Authentication: process of verifying who a user is
    Authorization: process of verifying what they have access to
    Identity Access Management  
    
  Terraform needs access credentials with relevant permissions to create and manage the environments  
  
  Access Credentials:
    AWS, access keys and secret keys
    GitHub, tokens
    Kubernetes , kubeconfig file, credentials config
    Digital Ocean, tokens
  Create user in AWS
    Add AdminsitratorAccess policy to user
    Once user is created, can generate access and secret keys
    
Configurations:
  Region
  CPU
  Memory
  Storage
  Operating System


**Don't hard code credentials in Terrfarom configuration, use environment variables**

Make sure your terminal is in the same location as youre terraform file

        terraform init #terraform will download appropriate plugins associated to new provider
        terraform plan #displays what terraform is planning on creating
        terraform apply #creates the resources 

**Provider Plugings**  

A provider is a plugin that lets Terraform manage an external API

When we run terraform init, plugins requred for the provider are automatically downloaded and saved locally to a .terraform directory 

Terraform support multiple providers 


Resource block describes one or more infrastructure objects 

            resource aws_instance
            resource aws_alb
            resource iam_user
            resource digitialocean_droplet

Resource type and Name together server as an identifier for a given resouce and so must be unique

            resource "aws_instance" "myec2"{
                ami = "ami-081343241321324"
                instance_type = "t2.micro"
            }

            resource "aws_instance" "web"{
                ami = "ami-081343241321324"
                instance_type = "t2.micro"
            }

            
Destroy resouces when you no longer need them to save on costs
-target flag combination of resource type and local resource name 
-taget aws_instance.myec2
        
        terraform destroy #destroys all resources
        terraform destroy -target aws_instance.myec2 #only destroy specified resource

As long as code to create resource is still present in the terraform file, it will recreate the resource.

Multiple ways to destory resources:

commenting out resource code from terraform file and then terraform plan, terraform apply  

deleting resource code from terraform file and then terraform plan, terraform apply  

terraform destroy   




**Terraform State File:** located in the same directory as terraform on local machine: terraform.tfstate  

terraform stores the state of the infrastructure that is being created from the TF files  

This state allows terraform to map real world resource to your existing configuration  

stores resource configuration and settings in the Terraform State file

example:
myec2 ====> instance-id, instance-type, security group, private-ip, volume-type, volume-size, public-ip

avoid making changes to terraform.tfstate and make a backup of statefile 


**Understand Desired vs Current State**  

Desired State:
terraforms primary function is to create, modify, and destroy infrastructure resources to match the desired state described in a Terraform Configuration.
configurations specified in Terraform file

Current State is the actual state of a resource that is currently deployed
example: you manually change state or type of ec2 instance without updating terraform file (desired state)

Terraform tried to ensure that the deployed infrastructure is based on the desired state.
If there is a difference between the two, terraform plan presents a description of the changes necessary to achieve the desired state

Desired State is priortized over current

example update security group in myec2 to custom instead of default

        terraform refresh #updates tf state file with custom
        terraform plan #returns no error

no error was returned because the security group configuration was not included in the resource block in the TF file












    























