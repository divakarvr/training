
/*==== The VPC ======*/
resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "${var.environment}-vpc"
    Environment = "${var.environment}"
  }
}
/*==== Subnets ======*/
/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "ig" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name        = "${var.environment}-igw"
    Environment = "${var.environment}"
  }
}

/* Elastic IP for NAT */
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.ig]
}
/* NAT */
resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id     = aws_subnet.public_subnet.id
  depends_on    = [aws_internet_gateway.ig]

  tags = {
     Name        = "nat"
     Environment = "${var.environment}"
  }
}

/* Public subnet */
resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = var.public_subnets_cidr
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.environment}-public-subnet"
    Environment = "${var.environment}"
  }
}
/* Private subnet */
resource "aws_subnet" "private_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = var.private_subnets_cidr
  map_public_ip_on_launch = false
  tags = {
    Name        = "${var.environment}-private-subnet"
    Environment = "${var.environment}"
  }
}

/* Routing table for private subnet */
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name        = "${var.environment}-private-route-table"
    Environment = "${var.environment}"
  }
}
/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name        = "${var.environment}-public-route-table"
    Environment = "${var.environment}"
  }
}
/* Routing public subnet with internet gateway*/
resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.ig.id}"
}
/* Routing private subnet with internet gateway*/
resource "aws_route" "private_nat_gateway" {
  route_table_id         = "${aws_route_table.private.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat.id}"
}

/* Route table associations */
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = "${aws_route_table.public.id}"
}
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = "${aws_route_table.private.id}"
}

/*==== VPC's Default Security Group ======*/
resource "aws_security_group" "default" {
  name        = "${var.environment}-default-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = "${aws_vpc.vpc.id}"
  depends_on  = [aws_vpc.vpc]
  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Environment = "${var.environment}"
  }
}
output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}


resource "aws_instance" "dev-pub-instance" {
  ami           = "ami-01c647eace872fc02" # us-west-2
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public_subnet.id
  key_name = "test1"
  vpc_security_group_ids =[aws_security_group.default.id]
    tags = {
    Name    = "${var.environment}-public"
  }
}

resource "aws_instance" "dev-pri-instance" {
  ami           = "ami-01c647eace872fc02" # us-west-2
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private_subnet.id
  key_name = "test1"
  vpc_security_group_ids=[aws_security_group.default.id]
  tags = {
  Name    = "${var.environment}-private"

  }
}