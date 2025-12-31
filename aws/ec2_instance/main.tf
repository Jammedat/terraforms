resource "tls_private_key" "tpk" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "aws_key_pair" "kp" {
    key_name = "nautilus-kp"
    public_key = tls_private_key.tpk.public_key_openssh
}

data "aws_security_group" "main" {
    name  = "default"
}

resource "aws_instance" "example" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  key_name      = "nautilus-kp"
  vpc_security_group_ids  = [data.aws_security_group.main.id]

  tags = {
    Name = "nautilus-ec2"
  }
}