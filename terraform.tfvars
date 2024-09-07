instance_data = {
  public = {
    ami                         = "ami-0a0e5d9c7acc336f1"
    instance_type               = "t2.micro"
    instance_name               = "public-instance"
    associate_public_ip_address = true
    subnet_key                  = "public-subnet"

  }
  private = {
    ami                         = "ami-0a0e5d9c7acc336f1"
    instance_type               = "t2.micro"
    instance_name               = "private-instance"
    associate_public_ip_address = false
    subnet_key                  = "private-subnet"

  }
}


subnet_data = {
  public-subnet = {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-1a"
  }
  private-subnet = {
    cidr_block        = "10.0.2.0/24"
    availability_zone = "us-east-1a"
  }

}