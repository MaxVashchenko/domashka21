# dom21 terraform

provider "aws" {
  region = var.region
}

# Creating VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
    environment = "prod"
  }
}

# Creating Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
    environment = "prod"
  }
}

# Creating Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.private_subnet_cidr_block 
  availability_zone       = var.availability_zone
  tags = {
    Name = "private-subnet"
    environment = "prod"
  }
}

# Creating Security Group for Jenkins Controller
resource "aws_security_group" "jenkins_sg" {
  vpc_id = aws_vpc.my_vpc.id
  name   = "jenkins-sg"
}

# Creating Security Group for App Server
resource "aws_security_group" "app_server_sg" {
  vpc_id = aws_vpc.my_vpc.id
  name   = "app-server-sg"
}

# Creating EC2 Instances
resource "aws_instance" "jenkins_controller" {
  ami                    = var.ami-0c7217cdde317cfec
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  security_group         = [aws_security_group.jenkins_sg.id]
  associate_public_ip    = true
  tags = {
    Name       = "jenkins-controller"
    environment = "prod"
    role       = "jenkins"
  }
}

resource "aws_instance" "app_server" {
  ami                    = var.ami-0c7217cdde317cfec
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_subnet.id
  security_group         = [aws_security_group.app_server_sg.id]
  tags = {
    Name       = "app-server"
    environment = "prod"
    role       = "application"
  }
}