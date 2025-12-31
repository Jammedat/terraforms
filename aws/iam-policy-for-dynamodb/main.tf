resource "aws_dynamodb_table" "main" {
    name = var.KKE_TABLE_NAME
    billing_mode   = "PAY_PER_REQUEST"
    hash_key = "UserId"
    attribute {
    name = "UserId"
    type = "S"
  }
    tags = {
      Name = var.KKE_TABLE_NAME
    }
  
}


resource "aws_iam_policy" "policy" {
  name        = var.KKE_POLICY_NAME

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Action": [
          "dynamodb:DescribeImport",
          "dynamodb:DescribeContributorInsights",
          "dynamodb:ListTagsOfResource",
          "dynamodb:GetAbacStatus",
          "dynamodb:DescribeReservedCapacityOfferings",
          "dynamodb:PartiQLSelect",
          "dynamodb:DescribeTable",
          "dynamodb:GetItem",
          "dynamodb:DescribeContinuousBackups",
          "dynamodb:DescribeExport",
          "dynamodb:GetResourcePolicy",
          "dynamodb:DescribeKinesisStreamingDestination",
          "dynamodb:DescribeLimits",
          "dynamodb:BatchGetItem",
          "dynamodb:ConditionCheckItem",
          "dynamodb:Scan",
          "dynamodb:Query",
          "dynamodb:DescribeStream",
          "dynamodb:DescribeTimeToLive",
          "dynamodb:ListStreams",
          "dynamodb:DescribeGlobalTableSettings",
          "dynamodb:GetShardIterator",
          "dynamodb:DescribeGlobalTable",
          "dynamodb:DescribeReservedCapacity",
          "dynamodb:DescribeBackup",
          "dynamodb:DescribeEndpoints",
          "dynamodb:GetRecords",
          "dynamodb:DescribeTableReplicaAutoScaling"
        ],
        Effect   = "Allow"
        Resource = "arn:aws:dynamodb:us-east-1:000000000000:table/devops-table"
      },
    ]
  })
}

resource "aws_iam_role" "test_role" {
  name = var.KKE_ROLE_NAME

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "main" {
    role = aws_iam_role.test_role.name
    policy_arn = aws_iam_policy.policy.arn
  
}