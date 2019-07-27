# security group for the instances
# traffic will go from the ELB to the instances.

resource "aws_security_group" "chl-elb-sg" {
  vpc_id = "${aws_vpc.chl-vpc.id}"
  name = "chl-elb-sg"
  description = "security group for the ELB"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "chule.io ELB SG"
  }
}

# main SG for instances
# traffic will be routed from the ELB
# will allow ssh traffic only from my local IP address.

resource "aws_security_group" "chl-sg" {
  vpc_id = "${aws_vpc.chl-vpc.id}"
  name ="chl-io-sg"
  description = "security group for the instances"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol ="tcp"
    security_groups = ["${aws_security_group.chl-elb-sg.id}"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    security_groups = ["${aws_security_group.chl-elb-sg.id}"]
  }

  tags = {
    name = "chule.io SG"
  }
}

# main SG for the instances
# will only allow traffic from instances

resource "aws_security_group" "rds-sg" {
  vpc_id = "${aws_vpc.chl-vpc.id}"
  name = "chl-rds-sg"
  description = "SG for the RDS"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = ["${aws_security_group.chl-sg.id}"]
  }

  tags = {
    name = "chule.io RDS SG"
  }
}
