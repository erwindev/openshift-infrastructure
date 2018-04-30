variable "vpc_cidr" {
  description = "The CIDR block of the VPC"
}

variable "project" {
  description = "The project"
}

variable "environment" {
  description = "The environment"
}

variable "region" {
  description = "The region to launch the bastion host"
}

variable "availability_zone" {
  description = "The az that the resources will be launched"
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
}

variable "key_name" {
  description = "The public key for the bastion host"
}
