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

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket-name

  tags = {
    Name        = "my_bucket"
  }
}


terraform {  
  backend "s3" {  
    bucket       = "my_bucket"  
    key          = "eks/lock/"  
    region       = "us-east-1"  
    encrypt      = true  
    use_lockfile = true  #S3 native locking
  }  
}


