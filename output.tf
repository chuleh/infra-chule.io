# outputs
output "instances_ip" {
  description = "EC2 IP 1"
  value       = "${aws_instance.chl1.public_ip}"
}

output "instance_ip" {
  description = "EC2 IP 2"
  value       = "${aws_instance.chl2.public_ip}"
}

output "rds_ip" {
  description = "RDS IP"
  value       = "${aws_db_instance.mariadb.endpoint}"
}
