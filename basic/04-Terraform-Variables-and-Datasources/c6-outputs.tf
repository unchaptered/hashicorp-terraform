# Terraform Output Block

output "instance_public_ip" {
    description = "EC2 Instance Public IP"
    value       = aws_instance.ec2demo.public_ip
}

output "instance_public_dns" {
    description = "EC2 Instance Public IP"
    value       = aws_instance.ec2demo.public_dns
}