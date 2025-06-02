terraform {
  backend "local" {
    path = "languagetool.tfstate"
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
  required_version = ">= 1.12.0"
}

provider "aws" {
  default_tags {
    tags = {
      Project = "languagetool"
    }
  }
}
