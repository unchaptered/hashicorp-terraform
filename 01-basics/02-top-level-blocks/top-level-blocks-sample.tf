terraform {                     
  required_version = "~> 0.14"  # 필수 Terraform 버전 설정
  required_providers {          # 필수 provider 설정 시작
    aws = {                         # AWS provider 설정 시작
      source  = "hashicorp/aws"     # provider의 이름과 소스 지정
      version = "~> 3.0"            # 필수 provider 버전 설정
    }
  }
  backend "s3" {                                # backend 설정 시작, S3 bucket 지정
    bucket = "terraform-stacksimplify"              # backend으로 사용할 S3 버킷 이름 설정
    key    = "dev2/terraform.tfstate"               # 상태 파일의 경로 및 이름 설정
    region = "us-east-1"                            # 버킷이 위치한 리전 설정
    dynamodb_table = "terraform-dev-state-table"    # backend로 사용할 DynamoDB 테이블 설정
  }
}                             

provider "aws" {              
  profile = "default"         # AWS profile 이름 지정
  region  = "us-east-1"       # AWS region 설정
}

resource "aws_instance" "ec2demo" {         # EC2 instance 생성 시작
  ami           = "ami-04d29b6f966df1537"       # 사용할 AMI ID 지정
  instance_type = var.instance_type             # 사용할 instance 타입 지정
}

variable "instance_type" {          # EC2 instance 타입을 지정하는 변수
  default     = "t2.micro"              # 기본값 지정
  description = "EC2 Instance Type"     # 변수에 대한 설명
  type        = string                  # 변수 타입 지정
}

output "ec2_instance_publicip" {            # 생성된 EC2 인스턴스의 public IP 주소 출력
  description = "EC2 Instance Public IP"        # 출력되는 값에 대한 설명
  value = aws_instance.my-ec2-vm.public_ip      # 출력할 값 지정
}

locals {                                                            # 로컬 변수 설정 시작
  bucket-name-prefix = "${var.app_name}-${var.environment_name}"        # bucket 이름을 생성하기 위한 접두사 지정
}

data "aws_ami" "amzlinux" {         # AWS AMI data source 설정
  most_recent      = true               # 가장 최근 AMI를 사용할 것인지 여부
  owners           = ["amazon"]         # AMI 소유자 지정

  filter {                          
    name   = "name"                     # AMI의 이름으로 필터링
    values = ["amzn2-ami-hvm-*"]        # 필터링할 값
  }

  filter {                       
    name   = "root-device-type"         # Root device 타입으로 필터링
    values = ["ebs"]                    # 필터링할 값
  }

  filter {                       
    name   = "virtualization-type"      # 가상화 타입으로 필터링
    values = ["hvm"]                    # 필터링할 값
  }

  filter {                          
    name   = "architecture"             # AMI 아키텍처로 필터링
    values = ["x86_64"]                 # 필터링할 값
  }
}

module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"   # ec2 instance를 구성하기 위한 module의 소스 경로
  version                = "~> 2.0"                                   # 사용할 module 버전

  name                   = "my-modules-demo"                           # 생성될 ec2 instance의 이름
  instance_count         = 2                                           # 생성할 ec2 instance 개수

  ami                    = data.aws_ami.amzlinux.id                    # ec2 instance에 사용할 AMI ID
  instance_type          = "t2.micro"                                  # ec2 instance의 instance type
  key_name               = "terraform-key"                             # ec2 instance에 접근하기 위한 key pair
  monitoring             = true                                        # ec2 instance의 모니터링 활성화 여부
  vpc_security_group_ids = ["sg-08b25c5a5bf489ffa"]                     # ec2 instance가 속할 보안 그룹의 ID
  subnet_id              = "subnet-4ee95470"                            # ec2 instance가 속할 subnet ID
  user_data               = file("apache-install.sh")                   # ec2 instance의 user data script

  tags = {                                                             # ec2 instance에 할당될 tag
    Terraform   = "true"
    Environment = "dev"
  }
}
