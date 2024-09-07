resource "aws_subnet" "subnets" {
  for_each          = var.subnet_data
  vpc_id            = aws_vpc.terraform-lab-vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = {
    Name = each.key
  }
}

