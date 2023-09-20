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

resource "aws_subnet" "demo-subnet" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = var.cidr_subnet
  tags = {
    Name = "${var.tag_name}-sub"
  }
}

resource "aws_route_table" "demo-rte" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-gw.id
  }

  tags = {
    Name = "${var.tag_name}-rte"
  }
}

resource "aws_network_acl" "demo-nacl" {
  vpc_id = aws_vpc.demo-vpc.id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  tags = {
    Name = "${var.tag_name}-nacl"
  }
}

resource "aws_network_acl_association" "Nacl-asso" {
  network_acl_id = aws_network_acl.demo-nacl.id
  subnet_id      = aws_subnet.demo-subnet.id
}

resource "aws_security_group" "demo-sg" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.demo-vpc.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.tag_name}-sg"
  }
}
