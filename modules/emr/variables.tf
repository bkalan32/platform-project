variable "name" {}
variable "release_label" {}
variable "applications" { type = list(string) }
variable "service_role_arn" {}
variable "instance_profile_name" {}
variable "subnet_id" {}
variable "master_instance_type" {}
variable "core_instance_type" {}
variable "core_instance_count" {}
variable "log_bucket" {}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "configurations_json" {
  type    = string
  default = "[]"
}

