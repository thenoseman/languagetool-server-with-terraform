terraform {

  backend "local" {
    path = "terraform.tfstate"
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
      Environment = "sandbox"
      Project     = "languagetool"
    }
  }
}
