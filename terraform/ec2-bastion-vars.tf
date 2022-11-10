variable "instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t3.small"  
}

variable "instance_keypair" {
  description = "AWS EC2 Key pair that need to be associated with EC2 Instance"
  type = string
  default = "eks-terraform-key"
}
