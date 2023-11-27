terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

#authentication
provider "github" {
  token = "............."
}

#create resource= repository

/*
resource "github_repository" "example" {
  name        = "example"
  description = "My awesome codebase"

  visibility = "public"
}
*/
#commenting or removing code from terraform will destroy the resource
