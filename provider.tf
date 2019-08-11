provider "aws" {
  region                  = "${var.AWS_REGION}"
  shared_credentials_file = "/Users/chuleh/.aws/credentials"
  profile                 = "default"
}
