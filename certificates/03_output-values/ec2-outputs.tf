output "ec2-elastic-ip-address" {

  value = "https://${aws_eip.lb.public_ip}"

}
