data "terraform_remote_state" "eip" {

  backend = "s3"

  config = {
    bucket  = "terraform-test-kevin"
    key     = "network/network.tfstate"
    region  = "ap-northeast-2"
    profile = "edint-prac-root"
  }
}
