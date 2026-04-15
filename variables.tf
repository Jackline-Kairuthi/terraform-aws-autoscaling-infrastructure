variable "vpc_id" {
  description = "The ID of the VPC where the resources will be created"
  type        = string
}

#variable "vpc-cidr" {
# description = "The CIDR block for the VPC"
#type        = string
#default     = "10.0.0.0/16"
#}

variable "igw_id" {
  description = "The ID of the Internet Gateway to attach to the VPC"
  type        = string
}

variable "region" {
  description = "The AWS region where the resources will be created"
  type        = string
}