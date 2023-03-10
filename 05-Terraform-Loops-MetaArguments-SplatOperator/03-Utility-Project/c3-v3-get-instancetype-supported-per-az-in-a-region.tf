data "aws_availability_zones" "my_azones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

data "aws_ec2_instance_type_offerings" "my_ins_type_3" {
  for_each = toset(data.aws_availability_zones.my_azones.names)
  filter {
    name   = "instance-type"
    values = ["t2.micro"]
  }
  filter {
    name   = "location"
    values = [each.key]
  }
  location_type = "availability-zone"
}


output "output_v3_1" {
    value = {
        for az, details in data.aws_ec2_instance_type_offerings.my_ins_type_3: az => details.instance_types
    }
}

# Outputs:
#
# output_v3_1 = {
#   "ap-northeast-2a" = tolist([
#     "t2.micro",
#   ])
#   "ap-northeast-2b" = tolist([])
#   "ap-northeast-2c" = tolist([
#     "t2.micro",
#   ])
#   "ap-northeast-2d" = tolist([])
# }


output "output_v3_2" {
    value = {
        for az, details in data.aws_ec2_instance_type_offerings.my_ins_type_3: 
          az => details.instance_types if length(details.instance_types) != 0
    }
}

# Outputs:
#
# output_v3_2 = {
#   "ap-northeast-2a" = tolist([
#     "t2.micro",
#   ])
#   "ap-northeast-2c" = tolist([
#     "t2.micro",
#   ])
# }


# Output-3
output "output_v3_3" {
  value = keys({
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type_3: 
    az => details.instance_types if length(details.instance_types) != 0 })
}


# Outputs:
#
# output_v3_3 = [
#   "ap-northeast-2a",
#   "ap-northeast-2c",
# ]


# Output-4 (additional learning)
# Filtered Output: As the output is list now, get the first item from list (just for learning)
output "output_v3_4" {
  value = keys({
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type_3: 
    az => details.instance_types if length(details.instance_types) != 0 })[0]
}


# Outputs:
# 
# output_v3_4 = "ap-northeast-2a"