module "vpc" {                          
  source  = "terraform-aws-modules/vpc/aws"  # 모듈 소스 설정
  version = "2.78.0"                         # 모듈 버전 설정

  name = "${local.name}-${var.vpc_name}"     # VPC 이름 설정
  cidr = var.vpc_cidr_block                  # VPC CIDR 설정 

  azs             = var.vpc_availability_zones  # VPC의 AZ 영역 설정
  public_subnets  = var.vpc_public_subnets      # 퍼블릭 서브넷의 CIDR 설정
  private_subnets = var.vpc_private_subnets     # 프라이빗 서브넷의 CIDR 설정   

    # 데이터베이스 서브넷의 CIDR 설정
  database_subnets = var.vpc_database_subnets
    # 데이터베이스 서브넷 그룹 생성 여부
  create_database_subnet_group = var.vpc_create_database_subnet_group
    # 데이터베이스 서브넷 그룹 에 대한 Routing Table 생성 여부
  create_database_subnet_route_table = var.vpc_create_database_subnet_route_table
  
  enable_nat_gateway = var.vpc_enable_nat_gateway  # NAT Gateway 활성화 여부
  single_nat_gateway = var.vpc_single_nat_gateway  # 단일 NAT 사용 여부, false시 AZ만큼 NAT 생성

  enable_dns_hostnames = true  # VPC의 인스턴스가 동일한 VPC 내의 리소스에 대한 DNS 이름을 확인할 수 있음(default: true)
  enable_dns_support   = true  # VPC의 인스턴스가 개인 IP 주소와 연결된 DNS 호스트 이름을 가질 수 있음(default: fales)


  tags = local.common_tags        # VPC 태그
  vpc_tags = local.common_tags    # VPC 하위 리소스 태그

  public_subnet_tags = {         # 퍼블릭 서브넷 태그
    Type = "Public Subnets"
  }
  private_subnet_tags = {        # 프라이빗 서브넷 태그
    Type = "Private Subnets"
  }  
  database_subnet_tags = {       # 데이터베이스 서브넷 태그
    Type = "Private Database Subnets"
  }
}
