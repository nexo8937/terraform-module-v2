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

#Private Subnets
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_ciders)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.private_subnet_ciders, count.index)
  availability_zone = data.aws_availability_zones.working.names[count.index]
  tags = {
    "Name" = "${var.app}-private-subnet-${count.index + 1}-${var.env}"
  }
}

#Database Subnets
resource "aws_subnet" "db_subnets" {
  count             = length(var.db_subnet_ciders)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.db_subnet_ciders, count.index)
  availability_zone = data.aws_availability_zones.working.names[count.index]
  tags = {
    "Name" = "${var.app}-db-subnet-${count.index + 1}-${var.env}"
  }
}
