resource "aws_vpc" "main" {
    cidr_block = var.KKE_VPC_CIDR
    tags = {
      Name = "nautilus-priv-vpc"
    }
  
}

resource "aws_subnet" "main" {
    cidr_block = var.KKE_SUBNET_CIDR
    vpc_id = aws_vpc.main.id
    tags = {
      Name = "nautilus-priv-subnet"
    }
  
}

resource "aws_security_group" "main" {
    name = "nautilus-sg"
    vpc_id = aws_vpc.main.id
  
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = var.KKE_VPC_CIDR
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = var.KKE_VPC_CIDR
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "main" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "main" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.main.id]
  subnet_id = aws_subnet.main.id

  tags = {
    Name = "nautilus-priv-ec2"
  }
}