terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "jenny-bucket"
    key            = "zero-trust/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
