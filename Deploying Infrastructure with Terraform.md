Authentication and Authorization:
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


Don't hard code credentials in Terrfarom configuration, use environment variables

Make sure your terminal is in the same location as youre terraform file

        terraform init #terraform will download appropriate plugins associated to new provider
        terraform plan #displays what terraform is planning on creating
        terraform apply #creates the resources 

Provider Plugings
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
        
        terraform destroy #destroys all resources
        terraform destroy -target aws_instance.myec2 #only destroy specified resource























