
#CREATING A VPC 

resource "aws_vpc" "vpc_workshop" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpcworkshop"
  }
}

#CREATING A PUBLIC SUBNET 

resource "aws_subnet" "workshop_public_subnet" {
  vpc_id     = aws_vpc.vpc_workshop.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "workshop_public_subnet"
  }
}


#CREATING A PRIVATE SUBNET

resource "aws_subnet" "workshop_private_subnet" {
  vpc_id     = aws_vpc.vpc_workshop.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "workshop_private_subnet"
  }
}

#  CREATING INTERNET GATEWAY

resource "aws_internet_gateway" "igw_workshop" {
  vpc_id = aws_vpc.vpc_workshop.id

  tags = {
    Name = "igw_workshop"
  }
}

# CREATING A PUBLIC ROUTE TABLE

resource "aws_route_table" "public_route_table_workshop" {
  vpc_id = aws_vpc.vpc_workshop.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_workshop.id
  }

  tags = {
    Name = "public_route_table_workshop"
  }
}



#  ROUTE TABLE ASSOCIATION TO PUBLIC SUBNET 

resource "aws_route_table_association" "public_route_table_assoc" {
  subnet_id      = aws_subnet.workshop_public_subnet.id
  route_table_id = aws_route_table.public_route_table_workshop.id
}



#  CREATING A PRIVATE ROUTE TABLE

resource "aws_route_table" "private_route_table_workshop" {
    vpc_id = aws_vpc.vpc_workshop.id

    route = []

    tags = {
        Name = "private_route_table_workshop"
    }
  
}

 #ROUTE TABLE ASSOCIATION TO PRIVATE SUBNET 

resource "aws_route_table_association" "private_route_table_assoc" {
  subnet_id      = aws_subnet.workshop_private_subnet.id
  route_table_id = aws_route_table.private_route_table_workshop.id
}
