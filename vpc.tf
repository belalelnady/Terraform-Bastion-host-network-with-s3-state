resource "aws_vpc" "terraform-lab-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "terraform-lab-vpc"
  }
}
