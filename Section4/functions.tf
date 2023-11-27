provider "aws" {
  region     = var.region
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

locals {
    time = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
}

variable "region"{
    default="us-east-1"
}

variable "tags"{
    type = list
    default = ["firstec2","secondec2"]
}
variable "ami"{
    type = map
    default = {
        "us-east-1" = "ami-12132412341"
        "us-west-1" = "ami-25345243425"
        "ap-south-1" = "ami-24543522342"
    }
}

resource "aws_key_pair" "loginkey"{
    key_name = "login-key"
    public_key = file("${path.module}/id_rsa.pub")
    #outputs the contents of the specified file
}
resource "aws_instance" "app-dev"{
    ami = lookup(var.ami,var.region) 
    #lookup(map, key)
    #retrieves the value of a single element from a map, given its key. If the key does not exist, the given default value is returned
    instance_type = "t2.micro"
    key_name = aws_key_pair.loginkey.key_name
    count = 2

    tags{
        Name = element(var.tags, count.index)
        #retrieves a single element from a list
        #count.index starts at 0 then increments
    }
}

output "timestamp" {
    value = local.time
}