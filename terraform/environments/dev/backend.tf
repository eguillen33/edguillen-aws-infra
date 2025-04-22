terraform {
  backend "s3" {
    bucket       = "edguillen-terraform-state"
    key          = "eks/dev/terraform.tfstate"
    region       = "us-west-2"
    encrypt      = true
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}