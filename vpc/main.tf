terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.cidr

  tags = {
    name = "my_vpc"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  count = length(var.private_subnet_cidr)
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone = var.availability_zone[count.index]
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  count = length(var.public_subnet_cidr)
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = var.availability_zone[count.index]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    name = "igw"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id

  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

   tags = {
    name = "rt"
  }
}

resource "aws_route_table_association" "private" {
  route_table_id = aws_route_table.rt.id
  count = length(var.private_subnet_cidr)
  subnet_id = var.private_subnet_cidr[count.index]
}

resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.rt.id
  count = length(var.public_subnet_cidr)
  subnet_id = var.public_subnet_cidr[count.index]
}

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
  from_port         = 80
  protocol       = "tcp"
  to_port           = 80
  cidr_blocks = ["0.0.0.0/0"]
}

ingress {
  from_port         = 443
  protocol       = "tcp"
  to_port           = 443
  cidr_blocks = ["0.0.0.0/0"]
}

egress {
  from_port = 0
  to_port = 0
  cidr_blocks =  ["0.0.0.0/0"]
  protocol       = "-1" # semantically equivalent to all ports
}
}