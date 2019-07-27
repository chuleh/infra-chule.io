# Networking

# VPC
resource "aws_vpc" "chl-vpc" {
  cidr_block           = "172.30.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    name = "chule.io default vpc"
  }
}

# Subnets
# instance subnets
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = "${aws_vpc.chl-vpc.id}"
  cidr_block              = "172.30.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2a"

  tags = {
    name = "public subnet 1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = "${aws_vpc.chl-vpc.id}"
  cidr_block              = "172.30.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2c"

  tags = {
    name = "public subnet 2"
  }
}

# RDS subnets
resource "aws_subnet" "private-subnet-1" {
  vpc_id                  = "${aws_vpc.chl-vpc.id}"
  cidr_block              = "172.30.3.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-2a"

  tags = {
    name = "private subnet 1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id                  = "${aws_vpc.chl-vpc.id}"
  cidr_block              = "172.30.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-2c"

  tags = {
    name = "private subnet 2"
  }
}

# Internet gateway
resource "aws_internet_gateway" "chl-gw" {
  vpc_id = "${aws_vpc.chl-vpc.id}"

  tags = {
    name = "internet gateway"
  }
}

# route table
resource "aws_route_table" "chl-rt" {
  vpc_id = "${aws_vpc.chl-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.chl-gw.id}"
  }

  tags = {
    name = "main route table"
  }
}

# route table associations
resource "aws_route_table_association" "chl-pub-sub-1a" {
  subnet_id      = "${aws_subnet.public-subnet-1.id}"
  route_table_id = "${aws_route_table.chl-rt.id}"
}

resource "aws_route_table_association" "chl-pub-sub-2c" {
  subnet_id      = "${aws_subnet.public-subnet-2.id}"
  route_table_id = "${aws_route_table.chl-rt.id}"
}

resource "aws_route_table_association" "chl-priv-sub-2a" {
  subnet_id      = "${aws_subnet.private-subnet-1.id}"
  route_table_id = "${aws_route_table.chl-rt.id}"
}

resource "aws_route_table_association" "chl-priv-sub-2c" {
  subnet_id      = "${aws_subnet.private-subnet-2.id}"
  route_table_id = "${aws_route_table.chl-rt.id}"
}
