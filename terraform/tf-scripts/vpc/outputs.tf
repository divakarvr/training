output "instance-private-ip" {
    value = aws_instance.demo-instance.private_dns
}

output "instance-arn" {
    value = aws_instance.demo-instance.arn
}