variable "AWS_REGION" {
    default = "us-east-2"
}

variable "AWS_AMI" {
  default = "ami-05c1fa8df71875112"
}

variable "PRIVATE_KEY" {
  default = "/home/chule/.ssh/chl-io"
}

variable "PUBLIC_KEY" {
  default = "/home/chule/.ssh/chl-io.pub"
}

variable "RDS_PASSWORD" {}
