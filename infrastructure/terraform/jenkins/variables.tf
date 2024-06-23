variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
  default     = "myKey"
}

variable "private_key_path" {
  description = "The path to the public key file"
  type        = string
  default     = "/mnt/c/Users/mkavi/Documents/tp_cloud/infrastructure/terraform/jenkins/myKey.pem"
}

variable "public_key_path" {
  description = "The path to the public key file"
  type        = string
  default     = "./myKey.pub"
}

variable "aws_region" {
  description = "The AWS region"
  type        = string
  default     = "eu-west-3"
}

variable "vpc_id" {
  description = "ID of the VPC where the EC2 instance will be launched"
  type        = string
  default     = "vpc-0fa9120c7fd67262f"
}

