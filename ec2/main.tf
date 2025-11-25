resource "aws_instance" "my_ec2" {
  instance_type = var.instantance_type
  ami = var.ami
}