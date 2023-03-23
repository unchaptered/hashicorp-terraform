# Get DNS Information from AWS Route53
data "aws_resource53_zone" "mydomain" {
    name        = "sample.domain.com"
}

# Output MyDomain
output "mydomain_zoneid" {
    description = "The Hoted Zone id of the desired Hosted Zone"
    value       = data.aws_resource53_zone.zone_id
}