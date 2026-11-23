resource "aws_vpc" "terraform_vpc" {    #4000 IPs
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {    #1000 IPs
  vpc_id = aws_vpc.terraform_vpc.id
  count = length(var.public_subnet_cidr_block)
  availability_zone = element(var.public_subnet_az, count.index)
  cidr_block = element(var.public_subnet_cidr_block, count.index)
  tags = {
    Name = "Public-subnet${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {    #1000 IPs
  vpc_id = aws_vpc.terraform_vpc.id
  count = length(var.private_subnet_cidr_block)
  availability_zone = element(var.private_subnet_az, count.index)
  cidr_block = element(var.private_subnet_cidr_block, count.index)
  tags = {
    Name = "Private-subnet${count.index + 1}"
  }
}

resource "aws_internet_gateway" "terraform_igw" {
  vpc_id = aws_vpc.terraform_vpc.id
  tags = {
    Name = "Terraform-vpc-igw"
  }
}

resource "aws_route" "internet_access" {
  route_table_id = aws_vpc.terraform_vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.terraform_igw.id
}

resource "aws_route_table_association" "public_subnet_association" {
  count = length(var.public_subnet_cidr_block)
  route_table_id = aws_vpc.terraform_vpc.default_route_table_id
  subnet_id = element(aws_subnet.public_subnet.*.id, count.index)
}
