variable "name" {
  type = string
  description = "Prefix for all VPC resources"
}

variable "vpc_cidr" {
  type = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
  type = list(string)
  description = "List of public subnet CIDRs"
}

variable "private_subnet_cidrs" {
  type = list(string)
  description = "List of private subnet CIDRs"
}

variable "azs" {
  type = list(string)
  description = "Availability zones"
}