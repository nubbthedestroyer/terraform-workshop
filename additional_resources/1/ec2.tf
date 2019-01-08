resource "aws_instance" "web" {
  ami           = "ami-23412345654"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}






