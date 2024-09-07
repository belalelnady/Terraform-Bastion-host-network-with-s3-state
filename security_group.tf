resource "aws_security_group" "allow-ssh" {
  description = "Allow SSH"
  vpc_id      = aws_vpc.terraform-lab-vpc.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    # -1 means aplly all protocols tcp ssh udp  etc...
    protocol = "-1"
  }
  tags = {
    "Name" = "Terraform-SG"
  }
}