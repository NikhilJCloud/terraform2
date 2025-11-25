variable "cidr" {
  description = "cidr for vpc"
  type        = string
}

variable "private_subnet_cidr" {
  description = "private subnet cidr"
  type        = list(string)
}

variable "public_subnet_cidr" {
  description = "public subnet cidr"
  type        = list(string)
}

variable "availability_zone" {
  description = "availability_zone"
  type        = list(string)
}

variable "instantance_type" {
  description = "instantance_type"
  default     = "t2.micro"
}

variable "ami" {
  default = "ami-0230bd60aa48260c6"
}

variable "bucket-name" {
  description = "bucket name"
  type        = string
}