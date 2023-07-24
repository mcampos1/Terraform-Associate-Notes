terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {
  token = "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"
}

resource "github_repository" "example" {
  name        = "example"
  description = "My awesome codebase"

  visibility = "public"
}
