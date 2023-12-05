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