variable "aws_region" {
  description = "AWS region where everything will be created"
  type        = string
  default     = "ap-south-1"
}

variable "project" {
  description = "Name prefix for all resources"
  type        = string
  default     = "devops-demo"
}

variable "instance_type" {
  description = "Size of the server"
  type        = string
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "Your AWS SSH key pair name for logging into the server"
  type        = string
}