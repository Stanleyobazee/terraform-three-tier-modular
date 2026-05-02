variable "project_name" { type = string }
variable "ami_id" { type = string }
variable "instance_type" { type = string }
variable "key_name" { type = string }
variable "app_sg_id" { type = string }
variable "app_subnet_ids" { type = list(string) }
variable "target_group_arn" { type = string }
variable "desired_capacity" {
  type    = number
  default = 2
}
variable "min_size" {
  type    = number
  default = 1
}
variable "max_size" {
  type    = number
  default = 4
}
