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
