[< 뒤로가기](../../README.md)

# 설명

이 문서는 [top-level-blocks-sample.tf](./top-level-blocks-sample.tf)에 대한 파일입니다.

학습 하면서 작성한 문서는 [Terrform에 대한 이해](https://unchaptered.notion.site/Terraform-5d41afa76d804027ac2d7c36d6602e51)에 포함되어 있습니다.

아래 내용은 위 문서를 복제한 것으로 최신 내용과 다를 수 있습니다.

B.2. Terraform Configuration 문법 영역을 확인해주세요.

### B.2. Terraform Configuration 문법

---

```powershell
# TEMPLATE
<BLOCK TYPE> "<BLOCK LEVEL>" "<BLOCK LABEL>" {

	# BLOCK BODY
	<IDENTIFIER> = <EXPRESSION or ARGUMENT VALUE>

}

# EXAMPLE
resource "aws_instance" "ec2demo" {
	ami             = "ami-030e520ec063f6467"
	instance_type   = "t2.micro"
}
```

Terraform으로 만드는 AWS Resource들은 arugment로 생성하고 일련의 attritubtes를 가지게 됩니다.

해당 정보는 해당 Resource의 <BLOCK LEVEL> arguement docs 등으로 검색하면 찾을 수 있습니다.

예)

- 검색어 : aws_instance argument docs
- 결과 : ****[Terraform Registry — Resource: aws_instance#argument-reference](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#argument-reference)

**B.2.1. Terraform Top-Level Blocsk란?**

---

**<TOP-LEVEL BLOCK>**은 Terrfarom Configuration 파일에서 가장 상위 레벨에서 정의도는 블록입니다.

일반적으로 Provider, Resource, Module, Data, Output 등을 정의하는데 사용됩니다.

이러한 블록은 Terraform 모듈의 기본 구조를 정의하고 인프라 리소스를 생성 및 관리하는데 중요합니다.

이는 각각 **<Fundamental BLOCK>,** **<Variables BLOCK>,** **<Calling / Referencing BLOCK>** 등으로 구성됩니다.

![**The kind of <TOP-LEVEL BLOCK>**](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f7fc9212-c1ca-484e-b995-33985c19e24a/Untitled.png)

**The kind of <TOP-LEVEL BLOCK>**

| BLOCK 타입 | BLOCK 유형 | 용도 및 목적 | 자세히 |
| --- | --- | --- | --- |
| Fundamental | 테라폼 블럭
(Terraform Block) | 테라폼 블럭은 Terraform과 Provider의 버전 등의 내용을 강제하기 위해서 작성합니다. | https://www.notion.so/Terraform-5d41afa76d804027ac2d7c36d6602e51 |
| Fundamental | 공급자
(Provider Block) | 공급자는 특정 클라우드 플랫폼(인프라) 제공자와 연결을 설정하는데 사용됩니다. | https://www.notion.so/Terraform-5d41afa76d804027ac2d7c36d6602e51 |
| Fundamental | 리소스
(Resource Block) | 리소스는 인프라를 정의하고 구성하는데 사용되는 중요한 정보를 담고 있습니다. | https://www.notion.so/Terraform-5d41afa76d804027ac2d7c36d6602e51 |
| Variable | 입력 변수
(Input Variables Block) | 보안상의 이유로 노출 시키면 안되는 값들을 하나의 .ts 파일에 기록하고 이를 .gitignore 처리 합니다. | https://www.notion.so/Terraform-5d41afa76d804027ac2d7c36d6602e51 |
| Variable | 출력 변수
(Output Values Block) | 출력 변수는 Terraform 구성 파일을 통해 만들어진 인프라의 특정 값을 외부로 출력하기 위해 사용됩니다. | https://www.notion.so/Terraform-5d41afa76d804027ac2d7c36d6602e51 |
| Variable | 로컬 변수
(Local Value Block) | 로컬 변수는 Terraform 구성 파일 내에서만 사용할 지역 변수를 선언하고 사용하는 데 사용됩니다. | https://www.notion.so/Terraform-5d41afa76d804027ac2d7c36d6602e51 |
| Calling / Referencing | 데이터 소스
(Data Source Block) | 데이터 소스는 Terraform 외부 리소스에 대한 정보를 가져오는데 사용헙나더,
일반적으로 외부 리소스의 정보가 Terraform 구성 파일에 필요한 경우에 사용됩니다. | https://www.notion.so/Terraform-5d41afa76d804027ac2d7c36d6602e51 |
| Calling / Referencing | 모듈
(Module Block) | 모듈은 Terraform에서 코드의 재사용성과 모듈화를 위해서 사용합니다. | https://www.notion.so/Terraform-5d41afa76d804027ac2d7c36d6602e51 |

**B.2.1. [Fundamental] 테라폼 블럭(Terraform)이란? → [표 보기](https://www.notion.so/Terraform-5d41afa76d804027ac2d7c36d6602e51)**

---

테라폼 블럭은 Terraform과 Provider의 버전 등의 내용을 강제하기 위해서 작성합니다.

**예시 파일**에서 테라폼 블럭은 다음과 같이 정의됩니다.

```powershell
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
```

- ‘**required_version**’ : Terraform 버전을 명시적으로 강제합니다.
- ‘**required_providers**’ : Terrform 에서 사용할 외부 인프라 공급자 버전을 명시적으로 강제합니다.
- ‘**backend**’ : Terraform 상태 파일`terraform.tfstate`을 저장할 위치를 지정합니다.
    - **‘bucket’, ‘key’, ‘region’** : Terraform 상태 파일이 저장될 s3 버킷 정보입니다.
    - ‘**dynamodb_table**’ : 여러 사용자가 동시에 같은 Terraform 인프라를 수정하지 못하도록 락(lock)을 활용하기 위해 반드시 DynamoDB가 필요합니다.
        
        [State: Locking | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/language/state/locking)
        

**B.2.1. [Fundamental] 공급자(Provider)이란? → [표 보기](https://www.notion.so/Terraform-5d41afa76d804027ac2d7c36d6602e51)**

---

공급자는 특정 클라우드 플랫폼(인프라) 제공자와 연결을 설정하는데 사용됩니다.

이를 통해서 AWS, Azure, GCP, VMware, Docker, Kubernetes 등 다양한 환경에서 인프라를 관리할 수 있습니다.

**B.2.1. [Fundamental] 리소스(Resource)이란? → [표 보기](https://www.notion.so/Terraform-5d41afa76d804027ac2d7c36d6602e51)**

---

리소스는 인프라를 정의하고 구성하는데 사용되는 중요한 정보를 담고 있습니다.

EC2, S3, RDS 등과 같은 다양한 리소스에 대한 정의를 할 수 있습니다.

**B.2.1. [Variables] 입력 변수(Input Value)란? → [표 보기](https://www.notion.so/Terraform-5d41afa76d804027ac2d7c36d6602e51)**

---

입력 변수는 Terraform에서 사용하기 위한 변수를 정의하는 코드입니다.

주로 보안상의 이유로 노출 시키면 안되는 값들을 입력 변수로 지정하고 별도의 `.tf` 파일로 관리합니다.

해당 파일은 `.gitignore` 안에 추가하여 Git과 같은 형상관리 툴이 추적하지 못하도록 만듭니다.

**예시 파일**에서 입력 변수는 다음과 같이 정의됩니다.
해당 파일은 학습용 파일로써, 비민감성 정보(pem 등을 제외한…)만을 선택적으로 공개하였습니다.

```
variable "instance_type" {          # EC2 instance 타입을 지정하는 변수
  default     = "t2.micro"              # 기본값 지정
  description = "EC2 Instance Type"     # 변수에 대한 설명
  type        = string                  # 변수 타입 지정
}
```

**B.2.1. [Variables] 출력 변수(Output Value)란? → [표 보기](https://www.notion.so/Terraform-5d41afa76d804027ac2d7c36d6602e51)**

---

출력 변수는 Terraform 구성 파일을 통해 만들어진 인프라의 특정 값을 외부로 출력하기 위해 사용됩니다.

출력 변수의 형태는 다음과 같습니다.

```powershell
output "변수명" {
	description = <변수 설명>
	value = <변수 값 or 표현식>
	type = <변수 타입>
}
```

**예시 파일**에서 출력 변수는 다음과 같이 정의됩니다.

```powershell

output "ec2_instance_publicip" {
  description = "EC2 Instance Public IP"        # 출력되는 값에 대한 설명
  value = aws_instance.my-ec2-vm.public_ip      # 출력할 값 지정
}
```

**B.2.1 [Variables] 로컬 변수**(Local Value)**란? → [표 보기](https://www.notion.so/Terraform-5d41afa76d804027ac2d7c36d6602e51)**

---

로컬 변수는 Terraform 구성 파일 내에서만 사용할 지역 변수를 선언하고 사용하는 데 사용됩니다.

로컬 변수는 출력값이 아니라 Terraform 구성 파일에서만 사용되는 값입니다.

**예시 파일**에서 로컬 변수는 다음과 같이 정의됩니다.

```powershell
locals {                                                            # 로컬 변수 설정 시작
  bucket-name-prefix = "${var.app_name}-${var.environment_name}"    # bucket 이름을 생성하기 위한 접두사 지정
}
```

**buckert-name-prefix**는 S3 버킷 이름을 생성할 때 네이밍 컨벤션을 지키기 위해서 **로컬 변수**를 사용합니다.

var.app_name과 var.environment_name은 **로컬 변수**을 통해서 주입받습니다.

위 **로컬 변수**는 모듈 내부에서 사용되지는 않지만, 모듈에서 정의한 리소스에서 사용할 수 있습니다.

**로컬 변수**를 사용함으로써 구성 파일 내에서 중복되는 문자열 값을 일일히 입력하지 않고도 코드를 더 깔끔하고 재사용 높게 유지할 수 있습니다.

**B.2.1. [Calling / Referencing] 데이터 소스(Data Source)란? → [표 보기](https://www.notion.so/Terraform-5d41afa76d804027ac2d7c36d6602e51)**

---

데이터 소스는 Terraform 외부 리소스에 대한 정보를 가져오는데 사용헙나더,

일반적으로 외부 리소스의 정보가 Terraform 구성 파일에 필요한 경우에 사용됩니다.

AWS, Azure, GCP 등의 클라우드 서비스, MySQL, PostgreSQL 등의 데이터베이스, DNS 레코드 등이 있습니다.

**예시 파일**에서 데이터소스는 다음과 같이 정의됩니다.

```powershell
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
```

**B.2.1. [Calling / Referencing] 모듈(Module)이란? → [표 보기](https://www.notion.so/Terraform-5d41afa76d804027ac2d7c36d6602e51)**

---

모듈은 Terraform에서 코드의 재사용성과 모듈화를 위해서 사용합니다.

일반적으로 다음과 같은 구조를 가집니다.

```powershell
module "MODULE_NAME" {
  source      = "MODULE_SOURCE"
  VERSION     = "MODULE_VERSION"
  [CONFIG ...]
}
```

- ‘MODULE_NAME’ : 모듈을 식별하기 위한 이름입니다.
- ‘MODULE_SOURCE’ : 모듈 소스의 위치입니다. 이 위치는 로컬 파일 경로, Git 리포지토리, Terraform 모듈 레지스트리 등이 될 수 있습니다.
- ‘MODULE_VERSION’ : 사용할 모듈 버전을 지정합니다. 이 버전은 SemVer(Semantic Versioning) 형식으로 지정되며, 생략 시 최신 버전이 지정됩니다.
- ‘CONFIG’ : 모듈의 입력 변수를 지정합니다. 이 입력 변수는 모듈에 전달되며, 모듈 내부에서만 사용됩니다.

유사한 용도는 [Terraform 리소스 블럭](https://www.notion.so/Terraform-5d41afa76d804027ac2d7c36d6602e51)이 존재하지만, 모듈이 훨씬 동적이고 재사용성이 높습니다.

**예시 파일**에서 모듈은 다음과 같이 정의됩니다.

```powershell
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
```