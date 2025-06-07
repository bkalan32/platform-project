variable "name" {
  type = string
}

variable "service" {
  type = string
  description = "Service to allow in assume role (e.g. ec2.amazonaws.com)"
}

variable "policy_arn" {
  type = string
  description = "Managed policy ARN to attach"
}

variable "tags" {
  type = map(string)
  default = {}
}