data "aws_instance" "main" {
    filter {
      name = "image-id"
      values = ["ami-0c101f26f147fa7fd"]
    }

}

resource "aws_ami_from_instance" "main" {
  source_instance_id = data.aws_instance.main.id
  name               = "datacenter-ec2-ami"