* local values can reference other local values
* TF_LOG=trace
* TF_LOG_PATH
* use datasources to get ami-id for each region lecture 41
* It is not necessary to specify version argument, Terraform will download the newest version of the module
* No additional code is required to implement Terraform state file lock
* use local values to modify expressions centrally lecture 39
* Terraform plan will show output to remove the manually created rule
* Terraform workspace, after terrform apply terraform.tfstate file will be in terraform.tfstate.d
* custom.tfvars works just need to explicitly point to the file terraform apply -var-file="custom.tfvars"
* child module has a variable, if the child module is called froma root module, the user can still set the value assocaited to the variable in the child module
    * can not override the instance_type of a child module from the root module directly
* by default when you create a workspace you are automatically switched into it
* Root module output vlaues is overrides child module 
* terrafi=orm cloud automatically runs a terraform plan when code is committed
* use remote provisioner to automatically install software inside ec2 after it is created 
* Terraform automatically covnerts number and bool values to strings when needed
* Terraform taint or terraform apply -replace, the resource will be recreated on the next terraform apply operation
* Read operations and terraform validate can still be run while state file is locked
* ~ in the terraform plan operations indicates that a resource will be updated
* use connection block to set credentials while defining terraform provisioners
* Terraform configuration files can be written in HCL and JSON
* provider plugins are stored in .terraform directory
* Terraform "default" workspace can not be deleted
* terraform import requires resoruce address and resource id 
* terraform cloud free version, team managemnet is not supported in the free version
* remote exec provisioners supported connection types: WinRM and ssh
* Terraform Enterprise currently supports running under the following operating systems:
    * Debian 10 / 11.
    * Ubuntu 18.04 / 20.04.
    * Red Hat Enterprise Linux 7.4 - 7.9 / 8.4 - 8.7 (RedHat Linux Requirements)
    * CentOS 7.4 - 7.9 / 8.4 (CentOS Requirements)
    * Amazon Linux 2.0.
    * Oracle Linux 7.4 - 7.9 / 8.4.
* variables files that are automatically loaded are any .auto.tfvars.json, terraform.tfvars, terraform.tfvars.json
* use data source to obtain ami ids for different regions
* backends that support state locking: azurem, consul
* datastorage supported by terraform enterprise postgreSQL
* VCS providers supported in Terraform Cloud
    * Github.com
    * Bitbucket Cloud
    * Azure DevOps Server
    * Azure DevOps Services
* There is no mechanism that can protect secrets in Terraform state files
* variables names can not be source, count, version, providers, for_each, lifecylce, depends_on, locals
* it is best practice to put provider version in terraform setting, as a different set of provider version can introduce unexpected bugs. 
* use "required_version" to contrain version of terraform or provider
* Terraform Cloud always encrypts state at rest and protects it with TLS in transit
* Terraform fmt scans current directory for configuration files
* Use terraform init to migrate state file to new backend
* Public modules on terraform registry extract module name, provider, documentation, input/output, and dependencies
* Terraform cloud and Terraform Enterprise manage and share sensitive values, and encrypt all variable values before storing them
* to specify a module version add "version = 0.5"
* reference ami id from a data source "data.aws_ami.ubuntu.id"
