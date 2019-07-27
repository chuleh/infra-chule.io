# creates 2 instances
resource "aws_instance" "chl1" {
  ami             = "${var.AWS_AMI}"
  instance_type   = "t2.micro"
  subnet_id       = "${aws_subnet.public-subnet-1.id}"
  security_groups = ["${aws_security_group.chl-sg.id}"]
  key_name        = "${aws_key_pair.chl-io.key_name}"

  user_data = <<-EOF
  #!/bin/bash
  apt-get update
  apt-get upgrade -y
  apt-get install -y python
  EOF
}

resource "aws_instance" "chl2" {
  ami = "${var.AWS_AMI}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public-subnet-2.id}"
  security_groups = ["${aws_security_group.chl-sg.id}"]
  key_name = "${aws_key_pair.chl-io.key_name}"

  user_data = <<-EOF
  #!/bin/bash
  apt-get update
  apt-get upgrade -y
  apt-get install -y python
  EOF
}
