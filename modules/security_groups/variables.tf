variable "vpc_id" { type = string }
variable "project_name" { type = string }
variable "trusted_cidr" {
  description = "Your IP CIDR for SSH access to bastion"
  type        = string
  default     = "0.0.0.0/0"
}
