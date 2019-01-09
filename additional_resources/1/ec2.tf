//
//  resource "aws_instance" "web" {
//    ami           = "ami-23412345654"
//    instance_type = "t2.micro"
//
//    tags = {
//      Name = "HelloWorld"
//    }
//
//    provisioner "local-exec" {
//      command = "echo \"created instance\""
//    }
//  }
//
//
//  resource "null_resource" "first_tf_run" {
//    provisioner "local-exec" {
//      command = "echo \"this command will execute on first apply\""
//    }
//  }
//
////provider "aws" {
////  region = "us-east-1"
////}
//
//
//  provider "aws" {
//    region     = "us-west-2"
//    access_key = "anaccesskey"
//    secret_key = "asecretkey"
//  }
//
//
//
//  data "terraform_remote_state" "s3_state" {
//    backend = "s3"
//    config {
//      bucket = "terraform-state-prod"
//      key    = "network/terraform.tfstate"
//      region = "us-east-1"
//    }
//  }
//
//  resource "aws_instance" "web" {
//    ami           = "ami-23412345654"
//    instance_type = "${data.terraform_remote_state.s3_state.instance_type}"
//  }
//
//
//
//  output "example_output" {
//    value = "${aws_instance.web.ami}"
//  }
//
//

  module "vpc" {
    source = "github.com/terraform-aws-modules/terraform-aws-vpc"
  }

