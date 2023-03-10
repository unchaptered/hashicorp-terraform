# Terraform Output Block

output "instance_public_ip" {
    description = "EC2 Instance Public IP"
    value       = aws_instance.ec2demo[*].public_ip
}

output "instance_public_dns" {
    description = "EC2 Instance Public IP"
    value       = aws_instance.ec2demo[*].public_dns
}

# For Loop를 사용한 list 생성
output "for_output_list" {
    description = "For Loop with List"
    value       = [for instance in aws_instance.ec2demo: instance.public_dns]
}


# For Loop를 사용한 Map 생성
output "for_output_map" {
    description = "For Loop with List"
    value       = {
        for instance in aws_instance.ec2demo: instance.id => instance.public_dns
    }
}

# For Loop를 사용한 Advanced Map 생성
output "for_output_map_2" {
    description = "For Loop with List"
    value       = {
        for count, instance in aws_instance.ec2demo: count => instance.public_dns
    }
}


# Legacy Splat(*) Opertaor
output "legacy_splat_operator_public_dns" {
    description = "Legacy Splat Operator"
    value       = aws_instance.ec2demo.*.public_dns
}


# Splat(*) Opertaor
output "splat_operator_public_dns" {
    description = "Splat Operator"
    value       = aws_instance.ec2demo[*].public_dns
}