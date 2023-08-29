provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

resource "aws_instance" "myec2" {
  ami = ami-04823729c75214919
  instance_type = "t2.micro"

  tags = {
      Name = "first ec2"
  }

#putting 2 resources of the same name results in an error when running terraform plan
#resource names must be unique per type in each module

resource "aws_instance" "myec2" {
  ami = ami-04
  instance_type = "t2.micro"

  tags = {
      Name = "first ec2"
  }

provider azurerm {}
#this is enough for terraform to download the appriopriate plugins with terraform init

##shared coonfig files 
provider "aws" {
  shared_config_files        = ["/Users/tf_user/.aws/conf"]
  shared_credentials_files   = ["/Users/tf_user/.aws/creds"]
  profile                    = "customprofile"
}

resource "aws_eip" "lb" {
  domain      = "vpc"
}

