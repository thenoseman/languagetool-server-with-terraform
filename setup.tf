terraform {
  backend "s3" {
    bucket = "languagetool-terraform-state"
    key    = "languagetool.tfstate"

    # No variables allowed here!
    # Change manually:
    region = "eu-central-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3"
    }
  }
  required_version = ">= 1.7.3"
}

provider "aws" {
  default_tags {
    tags = {
      Project = "languagetool"
    }
  }
}
