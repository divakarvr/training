resource "aws_vpc" "demo-vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "${var.tag_name}-vpc"
  }
}

resource "aws_internet_gateway" "demo-gw" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = {
    Name = "${var.tag_name}-igw"
  }
}