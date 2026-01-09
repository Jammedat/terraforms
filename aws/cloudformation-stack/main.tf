resource "aws_cloudformation_stack" "network" {
  name = "xfusion-stack"

  template_body = jsonencode({

    Resources = {
      mys3 = {
        Type = "AWS::S3::Bucket"
        Properties = {
          "BucketName" = "xfusion-bucket-20379"
          "VersioningConfiguration": {
                    "Status": "Enabled"
          }
          
        }
      }
    }
  })
}