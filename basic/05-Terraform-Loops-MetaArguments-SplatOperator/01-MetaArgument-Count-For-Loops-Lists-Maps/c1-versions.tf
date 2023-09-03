# Terraform Block
terraform {
  
  required_version = "~> 1.3"
    # "~> 0.14.8"
        # Allow 0.14.9 ~ 0.14.10 etc on
        # Deny 0.15.
    # "~> 0.14"
        # Alow 0.14.xx , 0.15.xx , 0.16.xx
        # Deny 1.xx

    required_providers {
        # 공급자 요구사항 : Provider Requirement
        # AWS 공급자 문서 : https://registry.terraform.io/providers/hashicorp/aws/latest/docs
        aws = {
            source = "hashicorp/aws"
            # [<HOSTNAME>/]<NAMESPACE>/<TYPE>
            version = "~> 4.5"
            # "~> 3.0"
                # Alow 3.xx
                # Deny 4.xx
        }
    }    

}

# Provider Block
provider "aws" {
    profile = "default"
    region =  var.aws_region
}