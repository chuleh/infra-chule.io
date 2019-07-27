# Launch configuration and Autoscaling
# Launch config
resource "aws_launch_configuration" "chl-io-lc" {
  name_prefix     = "chl-io-lc"
  image_id        = "${var.AWS_AMI}"
  instance_type   = "t2.micro"
  key_name        = "${aws_key_pair.chl-io.key_name}"
  security_groups = ["${aws_security_group.chl-sg.id}"]
}

# Autoscaling group
resource "aws_autoscaling_group" "chl-io-as" {
  name                      = "chl-io-as"
  vpc_zone_identifier       = ["${aws_subnet.public-subnet-1.id}", "${aws_subnet.public-subnet-2.id}"]
  launch_configuration      = "${aws_launch_configuration.chl-io-lc.name}"
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
}

# Autoscaling policy
resource "aws_autoscaling_policy" "chl-io-asp" {
  name                   = "chl-io-asp"
  autoscaling_group_name = "${aws_autoscaling_group.chl-io-as.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

# Cloudwatch alarm
resource "aws_cloudwatch_metric_alarm" "chl-io-cpu-alarm" {
  alarm_name          = "chl-io-cpu-alarm"
  alarm_description   = "chl-io-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.chl-io-as.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.chl-io-asp.arn}"]
}
