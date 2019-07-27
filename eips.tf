# 2 eips
resource "aws_eip" "chl-1" {
  instance = "${aws_instance.chl1.id}"
  vpc      = true
}

resource "aws_eip" "chl-2" {
  instance = "${aws_instance.chl2.id}"
  vpc      = true
}

resource "aws_eip_association" "eip_assoc_1" {
  instance_id   = "${aws_instance.chl1.id}"
  allocation_id = "${aws_eip.chl-1.id}"
}

resource "aws_eip_association" "eip_assoc_2" {
  instance_id   = "${aws_instance.chl2.id}"
  allocation_id = "${aws_eip.chl-2.id}"
}
