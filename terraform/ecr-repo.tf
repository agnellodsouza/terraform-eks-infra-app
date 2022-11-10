/*

- creating the ecr repo 

*/

resource "aws_ecr_repository" "erc-demo" {
  name                 = "${local.name}-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}
