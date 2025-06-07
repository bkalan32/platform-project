resource "aws_emr_cluster" "this" {
    name =var.name
    release_label = var.release_label
    applications = var.applications
    service_role = var.service_role_arn
    log_uri = "s3://${var.log_bucket}/emr-logs"


ec2_attributes {
    instance_profile = var.instance_profile_name
    subnet_id = var.subnet_id
}

master_instance_group {
    instance_type = var.core_instance_type
    instance_count = 1
}

core_instance_group {
    instance_type = var.master_instance_type
    instance_count = var.core_instance_count
}

configurations_json = var.configurations_json

tags = var.tags
}