# Data Source Block

data "aws_ec2_instance_type_offerings" "my_ins_type1" {

    filter {
        name    = "instance-type"
        values  = [var.instance_type]
    }

    filter {
        name    = "location"
        values  = [var.aws_region]
    }

    location_type = "availability-zone"

}

# Output Value Block

output "output_v1_1" {
    value   = data.aws_ec2_instance_type_offerings.my_ins_type1.instance_types
}

# Outputs:
#
# output_v1_1 = tolist([])
# (base) PS C:\AAA\terrafo