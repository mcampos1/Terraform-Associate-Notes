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


