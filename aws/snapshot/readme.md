Create a snapshot of an existing volume named nautilus-vol in us-east-1 region using terraform.

1) The name of the snapshot must be nautilus-vol-ss.

2) The description must be Nautilus Snapshot.

3) Make sure the snapshot status is completed before submitting the task.


### Solution
The volume was already created in the `main.tf` file as:  
```bash
resource "aws_ebs_volume" "k8s_volume" {
  availability_zone = "us-east-1a"
  size              = 5
  type              = "gp2"

  tags = {
    Name        = "devops-vol"
  }
}
```

Further you can verify if the volume exists by:  
`aws ec2 describe-volumes --filters Name=status,Values=available`