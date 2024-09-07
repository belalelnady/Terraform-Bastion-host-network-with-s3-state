resource "aws_internet_gateway" "internetgw" {
  vpc_id = aws_vpc.terraform-lab-vpc.id
  tags = {
    Name = "Terraform-internetgw"
  }
}
