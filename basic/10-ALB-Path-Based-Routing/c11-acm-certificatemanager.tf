# AWS Module - To Create and Verify SSL Certificates
module "acm" {

    source  = "terraform-module/acm/aws"
    version = "2.2.0"

    
    # 호스팅 영역에 기록된 이름의 마지막에는 온점(.)이 포함되어 있습니다.
    # 따라서, 테라폼 내장 함수 trimsuffix()를 이용하여 이를 제거할 수 있습니다.
        # BEFORE    : domain_name = data.aws_route53_zone.mydomain.name
        # AFTER     : domain_name = trimsuffix(data.aws_route53_zone.mydomain.name, ".")
    domain_name = trimsuffix(data.aws_route53_zone.mydomain.name, ".")

    subject_alternative_names = [
        "*.devopsincloud.com",
    ]

    tags = local.common_tags

}