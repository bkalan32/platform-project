provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = "kalan-demo-platform-bucket"
  force_destroy = true

  tags = {
    Name        = "Platform Demo"
    Environment = "Dev"
  }
}

module "vpc" {
  source = "../../modules/vpc"

  name                 = "dev"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
  azs                  = ["us-east-1a", "us-east-1b"]
}

module "emr_iam_role" {
  source     = "../../modules/iam"
  name       = "emr-role-dev"
  service    = "ec2.amazonaws.com"
  policy_arn = "arn:aws:iam::aws:policy/AmazonElasticMapReduceFullAccess"
  tags = {
    environment = "dev"
    owner       = "kalan"
  }
}

output "emr_instance_profile" {
  value = module.emr_iam_role.instance_profile_name
}

module "emr_service_role" {
  source     = "../../modules/iam"
  name       = "emr-service-role-dev"
  service    = "elasticmapreduce.amazonaws.com"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceRole"
  tags = {
    environment = "dev"
    owner       = "kalan"
  }
}


module "log_bucket" {
  source      = "../../modules/s3"
  bucket_name = "kalan-emr-logs-dev"
  tags = {
    environment = "dev"
    purpose     = "emr-logs"
  }
}

output "log_bucket_name" {
  value = module.log_bucket.bucket_name
}

module "aws_emr_cluster" {
  source                = "../../modules/emr"
  name                  = "platform-emr-dev"
  release_label         = "emr-7.8.0"
  applications          = ["Spark", "Hadoop"]
  service_role_arn = module.emr_service_role.role_arn
  instance_profile_name = module.emr_iam_role.instance_profile_name
  subnet_id             = module.vpc.public_subnet_ids[0]
  master_instance_type  = "m5.xlarge"
  core_instance_type    = "m5.xlarge"
  core_instance_count   = 2
  log_bucket            = module.log_bucket.bucket_name
  configurations_json   = "[]"

  tags = {
    environment = "dev"
    owner       = "kalan"
  }
}

output "emr_cluster_id" {
  value = module.aws_emr_cluster.cluster_id
}




