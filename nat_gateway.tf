# we need an ip to use with the nat
resource "aws_eip" "nat-ip" {
  #Elastic IP should be allocated for use within a VPC 
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat-ip.id
  subnet_id     = aws_subnet.public-subnet.id
  tags = {
    Name = "nat-gateway"
  }
}

