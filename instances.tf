resource "aws_instance" "ec2" {
  for_each = var.instance_data

  ami                         = each.value.ami
  instance_type               = each.value.instance_type
  subnet_id                   = aws_subnet.subnets[each.value.subnet_key].id
  vpc_security_group_ids      = [aws_security_group.allow-ssh.id]
  associate_public_ip_address = each.value.associate_public_ip_address

  key_name = aws_key_pair.kp.key_name

  depends_on = [aws_key_pair.kp , aws_security_group.allow-ssh]
  tags = {
    Name = each.key
  }

 
  # provisioner "local-exec" {
   
  #   command = each.key == "public" ? "sudo scp -i ~/.ssh/terraform-lab.pem ~/.ssh/terraform-lab.pem  ubuntu@${self.public_ip}:/home/ubuntu/.ssh/terraform-lab.pem" : "echo private instance"
  # }
}
