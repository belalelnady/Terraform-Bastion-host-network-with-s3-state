output "public-subnet-id" {
  value = aws_subnet.subnets["public-subnet"].id
}

output "private-subnet-id" {
  value = aws_subnet.subnets["private-subnet"].id
}