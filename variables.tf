variable "vpc_cidr_block" {
  default = "10.0.0.0/20"
}

variable "vpc_name" {
  default = "Terraform-vpc"
}

variable "public_subnet_cidr_block" {
  type = list(string)
  default = [ "10.0.2.0/23", "10.0.4.0/23" ]
}

variable "public_subnet_az" {
  type = list(string)
  default = [ "us-west-2a", "us-west-2b" ]
}

variable "private_subnet_cidr_block" {
  type = list(string)
  default = [ "10.0.8.0/22", "10.0.12.0/23" ]
}

variable "private_subnet_az" {
  type = list(string)
  default = [ "us-west-2a", "us-west-2b" ]
}

variable "ami_id" {
  default = "ami-091b3c7300f483e7d"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  default = "honda-unicorn-key"
}