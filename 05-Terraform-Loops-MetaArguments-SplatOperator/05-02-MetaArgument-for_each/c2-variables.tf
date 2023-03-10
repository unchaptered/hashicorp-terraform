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


# List Variabes
variable "instance_type_list" {
    description = "Instance Type List"
    type        = list(string)

    default     = [ "t3.micro", "t3.small" ]
}


# Map Variables
variable "instance_type_map" {
    description = "EC2 Instance Type"
    type        = map(string)
    
    default = {
        "dev"   = "t3.micro"
        "qa"    = "t3.small"
        "prod"  = "t3.large"
    }
}