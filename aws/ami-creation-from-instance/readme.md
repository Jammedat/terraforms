For this task, create an AMI from an existing EC2 instance named datacenter-ec2 using Terraform.

Name of the AMI should be datacenter-ec2-ami, make sure AMI is in available state.

# First Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "sg-a6b510eafe714132e"
  ]

  tags = {
    Name = "datacenter-ec2"
  }
}
