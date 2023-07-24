terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

# Configure the GitHub Provider
provider "github" {}

provider "github" {
  token = var.token # or `GITHUB_TOKEN`
}
