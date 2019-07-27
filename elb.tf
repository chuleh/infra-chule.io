# ELB
# will route traffic to both instances

resource "aws_elb" "chl-io-elb" {
  name = "chl-io-elb"
  subnets = ["${aws_subnet.public-subnet-1.id}", "${aws_subnet.public-subnet-2.id}"]
  security_groups = ["${aws_security_group.chl-elb-sg.id}"]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/"
    interval = 30
  }

  cross_zone_load_balancing = true
  connection_draining = true
  connection_draining_timeout = 400

  tags = {
    name = "chl.io ELB"
  }
}

# attach instance to ELB
resource "aws_elb_attachment" "chl-io-elb-attach" {
  elb = "${aws_elb.chl-io-elb.id}"
  instance = "${aws_instance.chl1.id}"
}

resource "aws_elb_attachment" "chl-io-elb-attach-2" {
  elb = "${aws_elb.chl-io-elb.id}"
  instance = "${aws_instance.chl2.id}"
}
