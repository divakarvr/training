
resource "aws_network_interface" "foo" {
  subnet_id = aws_subnet.demo-subnet1.id

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "demo-instance" {
  ami           = "ami-01c647eace872fc02" # us-west-2
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }
}