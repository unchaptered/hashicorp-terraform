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