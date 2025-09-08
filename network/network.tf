#data
data "aws_availability_zones" "working" {}

#VPC
resource "aws_vpc" "vpc" {
  #  count      = var.vpc_cidr_block != null ? 1 : 0
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.app}-vpc-${var.env}"
  }
}
