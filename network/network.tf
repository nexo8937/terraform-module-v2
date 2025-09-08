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

resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_ciders)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.public_subnet_ciders, count.index)
  availability_zone       = data.aws_availability_zones.working.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.app}-public-subnet-${count.index + 1}-${var.env}"
  }
}
