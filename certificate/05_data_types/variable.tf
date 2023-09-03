variable "usernumber" {
  type = number
}
variable "username" {}

variable "elb_name" {
  type = string
}
variable "elb_avzones" {
  type = list(any)
}
variable "elb_timeout" {
  type = number
}

variables "elb_type" {
  type = map
  defualt = {
    us-east-1 = "hello"
    us-east-2 = "hi"
    us-east-3 = "quakquak"
  }
}
