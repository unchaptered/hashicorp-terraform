variable "aws_region" {
    description = "AWS Region for Resources"
    type        = string
    default     = "ap-northeast-2"
}

variable "aws_profile" {
    description = "AWS Profile for Credential of AWS CLI2"
    type        = string
    default     = "default"
}

variable "service_name" {
    description = "Service Name"
    type        = string
    default     = "muyaho"
}

variable "aws_ec2_instance_type" {
    description = "AWS EC2 Instance Type"
    type        = string
    default     = "t2.micro"
}