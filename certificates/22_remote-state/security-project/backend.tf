terraform {
  backend "s3" {
    bucket  = "terraform-test-kevin"
    key     = "security/security.tfstate"
    region  = "ap-northeast-2"
    profile = "edint-prac-root"
  }
}
