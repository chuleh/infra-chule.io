# RDS - MariaDB
resource "aws_db_subnet_group" "chlio-mariadb-sub-group" {
  name = "mariadb-subnet"
  description = "RDS subnet group"
  subnet_ids = ["${aws_subnet.private-subnet-1.id}", "${aws_subnet.private-subnet-2.id}"]
}

resource "aws_db_instance" "mariadb" {
  allocated_storage = 25
  engine = "mariadb"
  engine_version = "10.3"
  instance_class = "db.t2.micro"
  identifier = "chliomariadb"
  name = "chliomariadb"
  username = "Master_User"
  password = "${var.RDS_PASSWORD}"
  db_subnet_group_name = "${aws_db_subnet_group.chlio-mariadb-sub-group.name}"
  storage_type = "gp2"
  vpc_security_group_ids = ["${aws_security_group.rds-sg.id}"]
  snapshot_identifier = "snapshot"
  skip_final_snapshot = true

  tags = {
    name = "chl.io mariadb instance"
  }
}
