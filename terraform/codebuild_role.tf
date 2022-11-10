/*
this files create the IAM role and attaches the required policies to it . 
	- ensure access to ECR  ( for login only ) 
	- ensurs access to EKS 
	- ensure acess to s3 ( read only ) 
*/

resource "aws_iam_role" "containerAppBuildProjectRole" {
  name = "${local.name}-app-Codebuild-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "containerAppBuildProjectRolePolicy" {
  role = aws_iam_role.containerAppBuildProjectRole.name
  name = "${local.name}-containerAppBuildProjectRole"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
      {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:${var.aws_region}:${var.AwsAccountNumber}:log-group:/aws/codebuild/${local.name}-codebuild",
                "arn:aws:logs:${var.aws_region}:${var.AwsAccountNumber}:log-group:/aws/codebuild/${local.name}-codebuild:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::codepipeline-${var.aws_region}-*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages"
            ],
            "Resource": [
                "arn:aws:codebuild:${var.aws_region}:${var.AwsAccountNumber}:report-group/${local.name}-codebuild*"
            ]
        },

        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:${var.aws_region}:${var.AwsAccountNumber}:log-group:${local.name}-codebuild-log-group",
                "arn:aws:logs:${var.aws_region}:${var.AwsAccountNumber}:log-group:${local.name}-codebuild-log-group:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },


        {
            "Sid": "AllowPush",
            "Effect": "Allow",
            "Action": [
                "ecr:*"
            ],
            "Resource": "arn:aws:ecr:${var.aws_region}:${var.AwsAccountNumber}:*"
        },

        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "eks:*",
            "Resource": [
                "arn:aws:eks:${var.aws_region}:${var.AwsAccountNumber}:cluster/${aws_eks_cluster.eks_cluster.name}",
                "arn:aws:eks:${var.aws_region}:${var.AwsAccountNumber}:cluster/${aws_eks_cluster.eks_cluster.name}/*"
            ]
        }


  ]
}
POLICY
}
