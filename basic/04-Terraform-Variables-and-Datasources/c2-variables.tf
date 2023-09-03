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

variable "instance_key_pair" {
    description = "AWS EC2 Key Pair that need to be associated with EC2 Instace"
    type        = string
    default     = "terraform-key"
}