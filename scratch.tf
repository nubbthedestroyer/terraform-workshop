

  resource "aws_instance" "web" {
    ami = "${var.ami}"
    instance_type = "${var.instance_type}"
    subnet = "${var.env == "production" ? var.prod_subnet : var.dev_subnet}"
  }


  resource "aws_subnet" "bar" {
    count      = "${var.enable_subnet}" #boolean
    vpc_id     = "${aws_vpc.foo.id}"
    cidr_block = "${cidrsubnet(aws_vpc.foo.cidr_block, 8, count.index)}"
  }

variable "ami" {}

variable "instance_type" {}

variable "env" {}

variable "prod_subnet" {}

variable "dev_subnet" {}