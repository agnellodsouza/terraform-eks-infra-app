output "ec2_bastion_public_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_public.id
}

output "ec2_bastion_public_ip" {
  description = "public IP associated to the Bastion Host"
  value       =  module.ec2_public.public_ip
}
