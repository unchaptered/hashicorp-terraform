# Terraform Output Block

output "instance_public_ip" {
    description = "EC2 Instance Public IP"
    # value       = aws_instance.ec2demo.*.public_ip      # Legacy Splat
    # value       = aws_instance.ec2demo[*].public_ip     # Latest Splat
    value       = toset([for instance in aws_instance.ec2demo: instance.public_ip])
}

output "instance_public_dns" {
    description = "EC2 Instance Public IP"
    # value       = aws_instance.ec2demo.*.public_dns         # Legacy Splat
    # value       = aws_instance.ec2demo[*].public_dns        # Latest Splat
    value       = toset([for instance in aws_instance.ec2demo: instance.public_ip])
}



output "instance_public_dns2" {
    value       = tomap({ for az, instance in aws_instance.ec2demo: az => instance.public_dns })
}