resource "aws_vpc" "demo-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "diva-vpcs"
  }
}

resource "aws_internet_gateway" "demo-gw" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = {
    Name = "diva-igws"
  }
}

resource "aws_subnet" "demo-subnet1" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "10.0.128.0/20"

  tags = {
    Name = "diva-subnet1"
  }
}

resource "aws_route_table" "demo-route1" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-gw.id
  }

  tags = {
    Name = "diva-route1"
  }
}

resource "aws_route_table_association" "demo-route-asso" {
  subnet_id      = aws_subnet.demo-subnet1.id
  route_table_id = aws_route_table.demo-route1.id
}

