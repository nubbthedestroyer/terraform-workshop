provider "aws" {
  region = "us-east-1"
}

module "s3_bucket1" {
  region = "us-east-1"
  source = "../modules/s3_bucket/"
}

module "s3_bucket2" {
  region = "us-west-2"
  source = "../modules/s3_bucket/"
}