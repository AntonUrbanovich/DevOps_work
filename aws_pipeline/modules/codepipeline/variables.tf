variable "iam_policy_arn" {
  description = "IAM Policy to be attached to role"
  type = "list"
}

variable "private_subnet_b" {
  type = string
  description = "It is subnet where will install container"
}

variable "security_group_id_vpc" {
  type = string
  description = "for use sg in ecs"
}

variable "vpc_id" {
  type = string
  description = "id for codepipeline"
}

variable "resource_name" {
  type = string 
  description = "names for different resources"
}

variable "project_name" {
  type = string
  description = " names for different projects"
}
variable "fullRepositoryId" {
  type = string
  description = "FullRepositoryId"
}
variable "branchName" {
  type = string
  description = "BranchName"
}

variable "cluster_name" {
  type = string
  description = "ClusterNameECS"
}

variable "service_name" {
  type = string
  description = "ServiceNameECS"
}

variable "bucket_name" {
  type = string
  description = "name for some bucket"
}

variable "buildspec" {
  type = string
  description = "special files of codebuild"
}
