data "aws_instances" "all_ec2" {
  instance_tags = {
    Name = "*"
  }
}

data "aws_instance" "individual" {
  count       = length(data.aws_instances.all_ec2.ids)
  instance_id = data.aws_instances.all_ec2.ids[count.index]
}

output "instance_ids" {
  value = [
    for instance in data.aws_instance.individual : {
      id            = instance.id
      instance_type = instance.instance_type
    }
  ]
  # value = data.aws_instances.all_ec2.ids
}
