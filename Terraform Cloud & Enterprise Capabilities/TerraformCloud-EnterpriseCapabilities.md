# Overview of Terraform Cloud

Terraform Cloud manages Terraform runs in a consistent and reliable environment with various features like access controls, private registry for sharing modules, policy controls and others. 

3 tiers
* Free
* Team & Governance
* Business

Create Workspace
* Version Control Workflow
    * connect to version control solution (VCS)
* CLI-driven workflow
* API-driven workflow
    * uses Terraform API

Create Environment Variables for credential values

Automatically detects new configurations files in github repo

# Overview of Sentinel

Sentinel is a policy-as-code framework integrated with HashiCorp Enterprise products.

Terraform plan > Sentinel Checks > Terraform apply

It enables fine-grained, logic-based policy decisionsm and can be extended to use information from external sources.

Sentinel policies are a paid feature

Connect Policy Set to Workspace 

Create Policies > Associate Policy to Policy Set

# Overview of Remote Backends

The remote backend stores Terraform state and may be used to run operations in Terraform Cloud

Terraform Cloud can also be used with local operations, in which case only state is stored in the Terraform Cloud backend

**Remote Operations** 
When using full remote operations, operations like terraform plan or terraform apply can be executed in Terraform Clouds run environment, with log output streaming to the local terminal. 

CLI-driven workflow 

    terrform {
        cloud {
            organization = "mykplas-org"
            workspaces {
                name = "remote-operation"
            }
        }
    }

    terraform login

    Then create an API token

# Air Gapped Environments

An air gap is a network security measure employed to ensure that a secure computer network is physically isolated from unsecured networks, such as the public internet. 

Terraform Enterprise installs using either an online or airgapped method and as the name infer, one requires internet connectivity the other does not. 