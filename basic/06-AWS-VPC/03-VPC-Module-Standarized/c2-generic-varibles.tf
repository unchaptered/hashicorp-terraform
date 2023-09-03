variable "aws_region" {
    description = "AWS Region for Resources"
    type        = string
}

variable "aws_profile" {
    description = "AWS Profile for Credential of AWS CLI2"
    type        = string
}

variable "service_name" {
    description = "Service Name"
    type        = string
}

variable "aws_ec2_instance_type" {
    description = "AWS EC2 Instance Type"
    type        = string
}

variable "environment" {
    description = "Environment Variables used as a prefix"
    type        = string
    default     = "dev"
}

variable "business_divison" {
    description = "Business Division in the large organization this Infrastructure belongs"
    type        = string
    default     = "SAP"
}