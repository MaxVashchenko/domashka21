#dom21
variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "availability_zone" {
  description = "Public subnet CIDR"
  type        = string
}


variable "public_subnet_cidr_block" {
  description = "Public subnet CIDR"
  type        = string
}

variable "private_subnet_cidr_block" {
  description = "Private subnet CIDR"
  type        = string
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}