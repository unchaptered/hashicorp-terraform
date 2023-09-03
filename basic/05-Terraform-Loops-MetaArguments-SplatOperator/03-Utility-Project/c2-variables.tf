# Input Value Block

variable "aws_region" {
    description = "Region in which AWS Resources to be created"  
    type            = string
    default         = "ap-northeast-2"
}

variable "instance_type" {
    description = "EC2 Instance Type"
    type        = string
    default     = "t2.micro"
}