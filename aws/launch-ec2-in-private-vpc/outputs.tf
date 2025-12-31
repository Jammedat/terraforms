output "KKE_vpc_name" {
  value = aws_vpc.main.tags.Name
}
output "KKE_subnet_name" {
  value = aws_subnet.main.tags.Name
}
output "KKE_ec2_private" {
  value = aws_instance.main.tags.Name
}