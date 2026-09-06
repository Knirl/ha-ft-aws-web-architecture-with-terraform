resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "ha-webapp-vpc"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block               = "10.0.1.0/24"
  availability_zone        = "ap-southeast-1a"
  map_public_ip_on_launch  = true

  tags = {
    Name = "public-subnet-a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block               = "10.0.2.0/24"
  availability_zone        = "ap-southeast-1b"
  map_public_ip_on_launch  = true

  tags = {
    Name = "public-subnet-b"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block         = "10.0.11.0/24"
  availability_zone  = "ap-southeast-1a"

  tags = {
    Name = "private-subnet-a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block         = "10.0.12.0/24"
  availability_zone  = "ap-southeast-1b"

  tags = {
    Name = "private-subnet-b"
  }
}