resource "aws_s3_bucket" "cicd_bucket" {
  bucket = "${local.name}-codepipeline-s3"
}


resource "aws_codepipeline" "node_app_pipeline" {
  name     = "${local.name}-app-pipeline"
  role_arn = aws_iam_role.apps_codepipeline_role.arn
  tags = "${merge(   { Environment = local.environment}, local.common_tags )}"

  artifact_store {
    location = aws_s3_bucket.cicd_bucket.id
    type     = "S3"
  }


stage {
    name = "Source"

    action {
      name = "Source"
      category = "Source"
      owner = "ThirdParty"
      provider = "GitHub"
      version = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        OAuthToken = var.githubtoken
        Owner = var.githubdetails["owner"]
        Repo = var.githubdetails["repo"]
        Branch = var.githubdetails["branch"]
      }
    }
  }

  stage {
    name = "Build"

    action {
      category = "Build"
      configuration = {
        "ProjectName" = aws_codebuild_project.containerAppBuild.name
      }
      input_artifacts = [
        "SourceArtifact",
      ]
      name = "Build"
      output_artifacts = [
        "BuildArtifact",
      ]
      owner     = "AWS"
      provider  = "CodeBuild"
      run_order = 1
      version   = "1"
    }
  }

}
