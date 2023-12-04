# Terraform Multiple Provider Configuration

Only one configuration is allowed per provider

Use alias to assign resources to allow a second provider configuration

    provider "aws" {
        alias = "mumbai"
        region = "ap-south-1"
    }

    resource "aws_eip" "myeip01" {
        vpc = "true"
        provider = "aws.mumbai" #assigns eip to provider configuration with alias mumbai
    }

# Handling Multiple AWS Profiles with Terraform Providers

    aws s3 ls --profile account-name #switch aws accounts through CLI

Launch resources in different profiles with different credentials

    provider "aws" {
        alias = "account02"
        region = "ap-south-1"
        profile = "account02" #
    }

     resource "aws_eip" "myeip01" {
        vpc = "true"
        provider = "aws.account02" 
    }

# Sensitive Parameter

When working with a field that contains information liekly to be considered sensitive, it is best to set the Senstive property on its schema to true

    output "db_password" {
        value = aws_db_instance.db.password
        description = "The password for logging in to the database."
        sensitive = true
    }

Setting the sensitive to "true" will prevent the fields values from showing up in CLI output and in Terraform Cloud.

**It will not encrypt or obscure the value in the terraform.tfstate file**

# HashiCorp Vault
allows organizations to securely store secrets like tokens, passwords, certificates along with access management for protecting secrets. 

Solution for:
* Secrets Management
* Data Encryption
* Access Management


Secrets can include, database passwords, AWS access/secret keys, API Tokens, encryption keys and others.

    vault read database/creds/readonly #display database credentials
    vault write ssh/creds/otp_key_role ip=131.231.413 #login into a linux instance 

# Terraform and Vault Integration 

The Vault provider allows Terraform to read from, write to, and configure HashiCorp Vault. 

check vault.tf

Interacting with Vault from Terraform causes any secrets that you read and write to be persisted in both Terraform's state file. 

# Dependency Lock File

Provider Plugins and Terraform are managed independently and have different release cycle. 

Version constraints within the configuration itself determine which versions of dependencies are potentially compatible

    terraform {
        required_providers {
            aws = {
                source = "hashicorp/aws"
                version = "~> 4.0"
            }
        }
    }

After selecting a specific version of each dependency Terraform remembers the decisions it made in a dependency lock file so that it can (by default) make the same decisions again in the future. 

    terraform init #update provider version configuration

If there is a requirement to use newer or downgrade a provider, you can override that behavior by adding the -upgrade option when you run terraform init, in which case Terraform will disregard the existing selections

    terraform init -upgrade #upgrade or downgrade

When installing a particular provider for the first time, Terraform will pre-populate the hashes value with any checksums that are covered by the provider developers cryptogrpachic signature, which usually covers all of the available packages for that provider version across all supported platforms.

The dependency lock file trakcs only provider dependencies. 

Terraform does not remember version selections for remote modules, and so Terraform will always select the newest available module version that meets the specified version constraints.






