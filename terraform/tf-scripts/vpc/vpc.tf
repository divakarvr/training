resource "aws_vpc" "demo-vpc" {
    cidr_block = var.cidr_block
    tags = {
        Name = var.vpc_name
    }
}

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.demo-vpc.id
    tags = {
        Name = var.igw_name
    }
}

