variable "aws_profile" {
  type = "string"
  description = "Name of the AWS profile to use for auth"
  default = "default"
}

variable "aws_region" {
  type = "string"
  description = "Which AWS region to use"
}

variable "ami_id" {
  type = "map"
  description = "AMI ID to use"
  default = {
    us-east-1 = "ami-fd6e3bea"
    us-west-2 = "ami-746aba14"
  }
}

variable "public_key" {
  type = "string"
  description = "Public key portion of ssh key for ssh access"
}

variable "ec2_instance_types" {
  type = "map"
  description = "Ec2 instance types to use per resource"
  default = {
    controller = "t2.micro"
    worker = "t2.micro"
  }
}
