#use exisiting VPC and internet gateway to create subnets for the Auto Scaling Group
data "aws_vpc" "main" {
  id = var.vpc_id
}

data "aws_internet_gateway" "main" {
  filter {
    name   = "internet-gateway-id"
    values = [var.igw_id]
  }
}

#create four subnets in the existing VPC
resource "aws_subnet" "az1" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.5.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "aws-subnet-1a"
  }
}

resource "aws_subnet" "az2" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.6.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "aws-subnet-1b"
  }
}

resource "aws_subnet" "az3" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.7.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "aws-subnet-1c"
  }
}

resource "aws_subnet" "az4" {
  vpc_id                  = var.vpc_id
  cidr_block              = "10.0.8.0/24"
  availability_zone       = "us-east-1d"
  map_public_ip_on_launch = true
  tags = {
    Name = "aws-subnet-1d"
  }
}

#create a public route table and using existing internet gateway to route traffic to the internet for the subnets
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
}

#Associate the public route table with the subnets
resource "aws_route_table_association" "az1" {
  subnet_id      = aws_subnet.az1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "az2" {
  subnet_id      = aws_subnet.az2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "az3" {
  subnet_id      = aws_subnet.az3.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "az4" {
  subnet_id      = aws_subnet.az4.id
  route_table_id = aws_route_table.public.id
}
