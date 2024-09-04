# --------------------instances-----
resource "aws_instance" "public-ec2" {
  ami = var.instance-ami
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public-subnet.id
  vpc_security_group_ids  = [aws_security_group.allow-ssh.id]

  key_name = aws_key_pair.kp.key_name


  tags = {
    Name = "public-ec2"
  }
}

# -------private
resource "aws_instance" "private-ec2" {
  ami = var.instance-ami
  instance_type = "t2.micro"
  subnet_id  = aws_subnet.private-subnet.id
  vpc_security_group_ids  = [aws_security_group.allow-ssh.id]

   key_name = aws_key_pair.kp.key_name

  tags = {
    Name = "private-ec2"
  }
}
