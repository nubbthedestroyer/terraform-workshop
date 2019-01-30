provider "aws" {
  region = "us-east-1"
}

variable "enable_bucket" {
  default = false
}

resource "aws_s3_bucket" "counted_bucket" {
  count = 2
  bucket_prefix = "counted-"
}

resource "aws_s3_bucket" "conditional_bucket" {
  count = "${var.enable_bucket}"
  bucket_prefix = "conditional-"
}

#####

locals {
  # 1 if yes and 0 if no
  should_i_create = 0
  create_condition = "${local.should_i_create == 0 ? 0 : 1}"
}

resource "aws_s3_bucket" "conditional_bucket2" {
  count = "${local.create_condition}"
  bucket_prefix = "conditional-"
}

resource "null_resource" "test_command" {
  provisioner "local-exec" {
    command = "echo blep"
  }
}