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

# Terraform Backends 
Backends primarily determine where Terraform stores its state.

By default, Terraform implicitly uses a backend called lcoal to store state as a local file on disk.

Don't store  terraform.tfstate file on local machine. (prevents collaboration)

**Ideal Architecture**
1. The Terraform code is stored in Git Repository
2. The state file is stored in a central backend

**Backends Supported in Terraform** 
Terraform supports multiple backends that allows remote service related operations. 

[Terraform-Backends](https://developer.hashicorp.com/terraform/language/settings/backends/configuration)

* S3
* Consul
* Azurerm
* Kubernetes
* HTTP
* ETCD 

Accessing state in a remote service generally requires some kind of access credentials. 
Some backends act like plain "remote disks" for state files; others support locking the state while operations are being performed, which helps prevent conflicts and inconsistencies.

Store access credentials for backend in configuration or in ~/.aws/config 

[Install-AWS-CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

    aws configure #to set access credentials
    s3 ls s3://bucket-name --region region name

# State Locking 
Whenever you are performing write operation, terraform would lock the state file. 
Otherwise during your ongoing terraform apply operations, if others also try for the same it can corrupt your state file. 

    terraform init #initialize backend
    terraform plan -lock=false #disable locking

State locking happens automatically on all operations that could write state. You won't see any message that it is happening. 
If state locking fails, terraform will not continue. 
Not all backends support locking. The documentation for each backend includes details on whether it supports locking or not. 

**Force Unlocking State** 
Terraform has a force-unlock command to manually unlock the state if unlocking failed. 
If you unlock the state when someone else is holding the lock it could cause multiple write operations. 
Force unlock should only be used to unlock your own lock in the situation where automatic unlocking failed. 
 
# Integrating DynamoDB with S3 for state locking
By default, S3 does not support State locking functionality. 
You need to make use of Dynamo DB table to achieve state locking functionality. 

add necessary configurations to backend.tf 
The table must have a partition key named LockID with type String. 

# Terraform State Management 
As your Terraform usage becomes more advanced, there are some cases where you may need to modify the Terraform state. 
It is important to never modify the state file directly.

    terraform state #better practice to modify terraform state

| State Sub Command | Description |
| --- | --- |
| list | List resources within terraform state file. |
| mv | Moves item with terraform state |
| pull | Manually download and output the state from remote state |
| push | Manually upload a local state file to remote state |
| rm | remove items from the Terraform state |
| show | Show the attributes of a single resource in the state | 

    terraform state list

The terraform state list command is used to list resources within a Terraform state.

    terraform state mv [options] source destination
    terraform state mv aws_instance.webapp aws_instance.myec2 #renames 

The terraform state mv command is used to move items in a Terraform state. This command is used in many cases in which you want to rename an existing resource without destroying and recreating it. Due to the destructive nature of this command, thsi command will output a backup copy of the state prior to saving any changes 

    terraform state pull 

The terraform state pull command is used to manually download and output the state from remote state. 
This is useful for reading values out of state (potentially pairing this command with something like jq)

    terraform state push 

The terraform state push command is used to manually upload a local state file to remote state. **this command should rarely be used**

    terraform state remove 

The terraform state rm command is used to remove items from the Terraform state. Items removed from the Terraform state are not physically destroyed. 
Items removed from the Terraform state are no longer managed by Terraform. 
For example, if you remove an AWS instance from the state, the AWS instance will continue running, but terraform plan will no longer see that instance. 

    terraform state show aws_instance.webapp

The terraform state show command is used to show the attributes of a single resource in the Terraform state. 

# Cross-Project Collaboration using Remote State

[terraform_remote_state](https://developer.hashicorp.com/terraform/language/state/remote-state-data)

The terraform_remote_state data sources retrieves the root module output values from some other Terraform configuration, using the latest state snapshot from the remote backend. 

    cidr_blocks      = ["${data.terraform_remote_state.eip.outputs.eip_addr}/32"]

check security-project/sg.tf,security-project/remote-state.tf, network-project/eip.tf, and network-project/backend.tf

# Implementing Remote State Connections 




