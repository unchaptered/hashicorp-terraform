provider "aws" {
  region  = "ap-northeast-2"
  profile = "edint-prac-root"
}

provider "aws" {
  alias = "second_provider"

  region  = "us-east-1"
  profile = "edint-prac-root"
}
