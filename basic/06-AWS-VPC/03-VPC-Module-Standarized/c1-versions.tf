# <Terraform Block>

terraform {

    required_version = "~> 1.3"

    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version     = "~> 3.0"
        }
    }

}

# <Provider Block>

provider "aws" {
    profile = var.aws_profile
    region = var.aws_region
}