
terraform {
  backend "s3" {
    bucket  = "terraform-test-kevin"
    key     = "network/network.tfstate"
    region  = "ap-northeast-2"
    profile = "edint-prac-root"
  }
}
