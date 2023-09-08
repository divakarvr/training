terraform {
  backend "s3" {
    bucket = "diva2023terraformstatefiles"
    key    = "tf-statefiles/vpc/vpc.tfstate"
    region = "us-east-1"
  }
}
