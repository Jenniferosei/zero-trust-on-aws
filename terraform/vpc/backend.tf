terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.47"
    }
  }

backend "s3" {
    bucket         = "jenny-bucket"  
    key            = "zero-trust/vpc/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
} 