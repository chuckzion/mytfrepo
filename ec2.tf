# CREATING EC2 INSTANCE IN THE PUBLIC SUBNET 

resource "aws_instance" "test-instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.workshop_public_subnet.id

  tags = {
    Name = var.instance_tags
  }
}

#CREATING EC2 INSTANCE IN THE PRIVATE SUBNET

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Canonical
}

/*


resource "aws_instance" "ec2_workshop" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.workshop_public_subnet.id 

  tags = {
    Name = var.instance_tags
  }
}


*/