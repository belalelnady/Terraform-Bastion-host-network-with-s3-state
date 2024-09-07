
#public rout table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.terraform-lab-vpc.id

  # connect to internet through the internet gw
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internetgw.id
  }
  tags = {
    Name = "public-route-table"
  }
}

#private rout table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.terraform-lab-vpc.id

  # connect to internet through the nat
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "private-route-table"
  }
}



# ------ to add the subnets to the route tables 
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private.id
}

