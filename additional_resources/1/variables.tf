//variable "instance_size" {
//  value = "t2.micro"
//  default = "t2.small"
//}
//
//
//  locals {
//    # blep
//    var1 = "blep"
//    # blep2
//    var2 = "${local.var1}2"
//    # blep-blep2
//    var3 = "${local.var1}-${local.var2}"
//  }
//
//
//
//
//  variable "vpc_id" {}
//
//  data "aws_vpc" "selected" {
//    id = "${var.vpc_id}"
//  }
//
//  resource "aws_subnet" "example" {
//    vpc_id            = "${data.aws_vpc.selected.id}"
//    availability_zone = "us-west-2a"
//    cidr_block        = "${cidrsubnet(data.aws_vpc.selected.cidr_block, 4, 1)}"
//  }
//
//
