# Get DNS Information from AWS Route53
data "aws_route53_zone" "mydomain" {
    name        = "devopsincloud.com"
}

# Output MyDomain
output "mydomain_zoneid" {
    description = "The Hoted Zone id of the desired Hosted Zone"
    value       = data.aws_route53_zone.mydomain.zone_id
}