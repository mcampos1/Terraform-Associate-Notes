# Challenge2

Separate code blocks into different files for each resource type

Format errors

    terraform fmt file-name
    terraform fmt tf-challenge-2.tf

Check curly brackets
Check if syntax if correct

    terraform validate 

Error with provider version
can change lock file

    terraform init -upgrade #installs latest version based off configuration file and updates lock file

Use Tags to label resources and add more metadata

Use a consistent and effective naming convention for resources
    * Updating name of a resource will destroy and recreate the resource

Use description field and comments to allow code to be understood and read easier

**Update Splunk variable without modifying code**

Use -var option to modify variable on the CLI
    terraform plan -var "splunk=8089" 
