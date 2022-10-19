#main.tf


terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }
  }

  backend "s3" {
    bucket = "tf-ansible-solr-dl"
    key    = "state.tfstate"
    region = "us-east-1" # Optional parameter. Will use AWS_DEFAULT_REGION env if this is not provided.
    #  Run terraform init --reconfigure if region var is changed
  }

  required_version = ">= 1.2.0"
}


