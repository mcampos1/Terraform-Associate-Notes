provider "aws" {
    #remove version constraint to run latest version of the provider
  region  = "us-east-1"
    #remove keys, add to aws profile using aws configure
}

resource "aws_eip" "kplabs_app_ip" {
    vpc      = true #deprecated
    domain = "vpc" 
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.54"
    }
    digitalocean = {
        source = "digitalocean/digitalocean"
    }

  }
}
