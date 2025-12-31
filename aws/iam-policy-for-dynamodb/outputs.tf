output "kke_dynamodb_table" {
    value = aws_dynamodb_table.main.name
  
}
output "kke_iam_role_name" {
    value = aws_iam_role.test_role.name
  
}
output "kke_iam_policy_name" {
    value = aws_iam_policy.policy.name
  
}