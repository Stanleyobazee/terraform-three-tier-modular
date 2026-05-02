output "alb_dns_name" {
  description = "ALB DNS name - use this to access the app"
  value       = module.alb.alb_dns_name
}

output "bastion_public_ip" {
  description = "Bastion host public IP for SSH access"
  value       = module.compute.bastion_public_ip
}

output "db_private_ip" {
  description = "DB instance private IP"
  value       = module.compute.db_private_ip
}

output "target_group_arn" {
  description = "ALB target group ARN"
  value       = module.alb.target_group_arn
}
