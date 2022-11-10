resource "aws_codebuild_project" "containerAppBuild" {
  badge_enabled  = false
  build_timeout  = 60
  name           = "${local.name}-codebuild"
  queued_timeout = 480
  service_role   = aws_iam_role.containerAppBuildProjectRole.arn
  tags = "${merge(   { Environment = local.environment}, local.common_tags )}"

  artifacts {
    encryption_disabled = false
    packaging = "NONE"
    type      = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
    type                        = "LINUX_CONTAINER"
	
 dynamic "environment_variable" {
   for_each = var.codebuild_env_vars
   content {
   name  = environment_variable.key
  value = environment_variable.value
     }
   }

  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
      group_name  = "${local.name}-codebuild-log-group"
      stream_name = "${local.name}-codebuild-log-stream"
    }

    s3_logs {
      encryption_disabled = false
      status              = "DISABLED"
    }
  }

  source {
    git_clone_depth     = 0
    insecure_ssl        = false
    report_build_status = false
    type                = "CODEPIPELINE"
    buildspec       = "app-code/buildspec.yaml"
  }
}
