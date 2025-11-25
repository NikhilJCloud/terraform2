module "vpc" {
  source = "./vpc"

  cidr                = var.cidr
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  availability_zone   = var.availability_zone

}



resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket-name


  tags = {
    Name        = "my_bucket"
  }
}

resource "aws_s3_object" "example" {
  key        = "lock"
  bucket     = aws_s3_bucket.my_bucket.id  
}

/*terraform {  
  
  backend "s3" {    
    bucket       = "my_bucket"  
    key          = "lock"  
    region       = "us-east-1"  
    encrypt      = true  
    use_lockfile = false  #S3 native locking
  }  
} */

module "ec2" {
  source = "./ec2"

  instantance_type = var.instantance_type
  ami              = var.ami
}