variable "aws_region" {
  description = "Region Nme "
  type = string
  default = "ap-south-1"  
}

variable "environment" {
  description = " prefixi env vairable"
  type = string
  default = "demo-naviteq"
}

variable "owner" {
  description = "owner of this application"
  type = string
  default = "agnello"
}
variable "cluster_name" {
  description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
  type        = string
  default     = "eks-demo-naviteq"
}

variable "localIP" {
  description = "my ISP IP"
  type        = list(string)
  default     = ["86.20.170.51/32"]
}
variable "AwsAccountNumber" {
  description = "account no"
  type        = string
  default     = "617686195573"
}
variable "githubtoken" {
  sensitive = true
}


variable "githubdetails" {
  type = map
  default = {
    "owner" = "agnellodsouza"
    "repo" = "terraform-eks-infra-app"
    "branch" = "main"
  }
}

variable "codebuild_env_vars" {
  default = {
    AWS_DEFAULT_REGION = "ap-south-1"
    IMAGE_REPO_NAME = "agnello-demo-naviteq-ecr"
    AWS_ACCOUNT_ID = "617686195573"
    AWS_CLUSTER_NAME = "agnello-demo-naviteq"
  }
} 
