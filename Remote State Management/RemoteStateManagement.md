# Integrating GIT for Team Management

avoid local changes, can risk losing configuration files and prevents collaboration

Bitbucket
Github
gitbash

    git clone https link
    git status
    git add .
    git commit -m "first git code"
    git config --global user.email "email"
    git config --global user.name "username"
    git push origin master

# Security Challenges in committing TFState to Git

**Never store passwords, secrets, api keys in git**

Use interpolation function to point to password in a separate file outside of the git repository

    password = "$(file(../rds_pass.txt))

point to file outside of the git directory that contains the password 

**Password is still displayed within the terraform.tfstate file**

Avoid pushing terraform.tfstate file to Git

# Module Sources in Terraform 

The source argument in a module block tells Terraform where to find the source code for the desired child module. 

* Local Paths
    * A local path must being with either ./ or ../ to indicate a local path is intended.
* Terraform Registry
* GitHub
* Bitbucket
* Generic Git, Mercurial repositories
* HTTP Urls
* S3 buckets
* GCS buckets
 
Git Module Source 
Arbitrary Git repositories can be used by prefixing the address with the special git::prefix

After this prefix, any valid Git URL can be specified to select one of the protocols supported by Git.

    module "vpc {
        source = "git::https://example.com"
    }
    module "vpc {
        source = "git::ssh://username@example.com/storage.git" 
    }

Referencing a different branch 

By default, Terraform will clone and use the default branch (referenced by HEAD) in the selected repository.

You can override this using the ref argument:

    module "vpc" {
        source = "git::https://example.com/vpc.git?ref=v.1.2.0"
    }

The value of the ref argument can be any reference that would be accepted by the git checkout command, including branch and tag names

# Terraform and .gitignore 

Depending on the environments, it is recommended to avoid committing certain files to GIT.

| Files to Ignore | Description |
| --- | --- |
| .terraform | This file will be recreated when terraform init is run |
| terraform.tfvars | likely to contain sensitive data like usernames/passwords and secrets |
| terraform.tfstate | should be stored in the remote side |
| crash.log | If terraform crashes, the logs are stored to a file named crash.log |

**Use .gitignore file to list files you dont want Git to push** 

    nano .gitignore
    .terraform
    *.tfvars #any file that ends with .tfvars
    terraform.tfstate
