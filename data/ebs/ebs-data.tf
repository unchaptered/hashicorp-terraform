data "aws_ebs_volumes" "all_volumes" {}

data "aws_ebs_volume" "ebs_volume" {
  count = length(data.aws_ebs_volumes.all_volumes.ids)
  filter {
    name   = "volume-id"
    values = [data.aws_ebs_volumes.all_volumes.ids[count.index]]
  }
}

output "instance_ids" {
  value = [
    for vol in data.aws_ebs_volume.ebs_volume : {
      id         = "${vol.id}"
      type       = "${vol.volume_type}"
      size       = "\"${vol.size}\""
      iops       = "\"${vol.iops}\""
      throughput = "\"${vol.throughput}\""
    }
  ]
}
