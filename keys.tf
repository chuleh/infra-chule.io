# ssh keys
resource "aws_key_pair" "chl-io" {
  key_name = "chl-io"
  public_key = "${file("${var.PUBLIC_KEY}")}"
}
