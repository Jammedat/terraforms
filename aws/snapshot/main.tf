
resource "aws_ebs_snapshot" "example_snapshot" {
  volume_id = aws_ebs_volume.k8s_volume.id
  description = "Devops Snapshot"

  tags = {
    Name = "devops-vol-ss"
  }

  lifecycle {
    create_before_destroy = true
  }
}