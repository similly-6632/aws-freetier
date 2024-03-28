# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.naming_prefix}-vpc"
  }
}

# IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.naming_prefix}-igw"
  }
}

# Subnet 1
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet1_cidr
  availability_zone = var.availability_zone1

  tags = {
    Name = "${var.naming_prefix}-subnet1"
  }
}

# Subnet 2
resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet2_cidr
  availability_zone = var.availability_zone2

  tags = {
    Name = "${var.naming_prefix}-subnet2"
  }
}

# Route Table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.naming_prefix}-rt"
  }
}
resource "aws_route_table_association" "rt_association1" {

    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.route_table.id
  
}
resource "aws_route_table_association" "rt_association1" {

    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.route_table.id
  
}