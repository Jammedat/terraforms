resource "aws_ebs_volume" "main" {
    availability_zone = "us-east-1"
    size = 2
    type = "gp3"
    tags = {
      Name = "devops-volume"
    }
  
}