variable "app_name" {
  description = "App Name"
  default     = "varun-api-staging"
}

variable "region" {
  default = "ap-southeast-1"
}

variable "owner" {
  default = "varun-api-staging"
}

variable "environment" {
  default = "staging"
}

variable "cluster_name" {
  default = "varun-api-staging-cluster"
}

variable "vpc_id" {
  type = string
}

variable "vpc_public_subnets" {
  type = list(string)
}

variable "vpc_private_subnets" {
  type = list(string)
}

variable "spoke_aws_account" {
  description = "[Required] AWS credentials for this spoke account"
  type = object({
    access_key = string
    secret_key = string
  })
}
