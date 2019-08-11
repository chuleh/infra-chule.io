variable "AWS_REGION" {
  default = "us-east-2"
}

variable "AWS_AMI" {
  default = "ami-05c1fa8df71875112"
}

variable "PRIVATE_KEY" {
  default = "/Users/chuleh/.ssh/id_rsa"
}

variable "PUBLIC_KEY" {
  default = "/Users/chuleh/.ssh/id_rsa.pub"
}

variable "RDS_PASSWORD" {}

variable "MY_IP" {}