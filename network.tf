
# --------------------VPC

resource "aws_vpc" "terraform-lab-vpc" {
  cidr_block = "10.0.0.0/16"
    tags = {
    Name = "terraform-lab-vpc"
  }
}

# --------------------Subnet
resource "aws_subnet" "public-subnet" {
  vpc_id   = aws_vpc.terraform-lab-vpc.id
  cidr_block     = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id            =  aws_vpc.terraform-lab-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "private-subnet"
  }
}

# ------GATEWAY------
resource "aws_internet_gateway" "internetgw" {
  vpc_id = aws_vpc.terraform-lab-vpc.id
  tags = {
    Name = "Terraform-internetgw"
  }
}

# -------NAT

# we need an ip to use with the nat
resource "aws_eip" "nat-ip" {
 #Elastic IP should be allocated for use within a VPC 
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat-ip.id
  subnet_id = aws_subnet.public-subnet.id
  tags = {
    Name = "nat-gateway"
  }
}




# -------ROUTING TABLE------

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



# ---------------Security group

resource "aws_security_group" "allow-ssh" {
  description = "Allow SSH"
  vpc_id = aws_vpc.terraform-lab-vpc.id


  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    # -1 means aplly all protocols tcp ssh udp  etc...
    protocol = "-1"
  }
  tags = {
    "Name" = "Terraform-SG"
  }
}