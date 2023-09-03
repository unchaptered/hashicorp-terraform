# Data Source Block

data "aws_ec2_instance_type_offerings" "my_ins_type2" {

    for_each = toset(["ap-northeast-2a", "ap-northeast-2c"])

    filter {
        name    = "instance-type"
        values  = [var.instance_type]
    }

    filter {
        name    = "location"
        values  = [each.key]
    }

    location_type = "availability-zone"

}

# Output Value Block

output "output_v2_1" {
    # value   = data.aws_ec2_instance_type_offerings.my_ins_type1.instance_type                     # 이 설정으로 미작동
    
    # value   = [for t in data.aws_ec2_instance_type_offerings.my_ins_type2: t.instance_types]      # 작동은 하지만 미권고
    value   = toset([for t in data.aws_ec2_instance_type_offerings.my_ins_type2: t.instance_types]) # 권고
}

# Outputs:
#
# output_v1_1 = [
#   tolist([
#     "t2.micro",
#   ]),
#   tolist([
#     "t2.micro",
#   ]),
# ]

output "output_v2_2" {
    value = {
        for az, details in data.aws_ec2_instance_type_offerings.my_ins_type2: az => details.instance_types
    } 
}

# Outputs:
#
#  output_v2_2 = {
#    + ap-northeast-2a = [
#        + "t2.micro",
#      ]
#    + ap-northeast-2c = [
#        + "t2.micro",
#      ]
#  }