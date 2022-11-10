
/*

- use this file to create maps or create a vairable with pattern 

*/

locals {
  owners = var.owner
  environment = var.environment
  
  name = "${var.owner}-${var.environment}"
  common_tags = {
    owners = local.owners
    environment = local.environment
  }
  eks_cluster_name = "${local.name}" 
} 
