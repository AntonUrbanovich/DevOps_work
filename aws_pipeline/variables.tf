variable "iam_policy_arn" {
 type = "list"
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
/*
variable "clusterName" {
  type = string
  description = "ClusterNameECS"
}

variable "serviceName" {
  type = string
  description = "ServiceNameECS"
}
*/
variable "bucket_name" {
  type = string
  description = "name for some bucket"
}


variable "buildspec" {
  type        = string
  description = "special files of codebuild"
}

#############ECS

variable "cluster_name" {
 type        = string
 description = "name of some cluster"  
}

variable "service_name" {
  type        = string 
  description = "name of some service"
}

variable "memory" {
  type = string 
  description = "value of memory"
}

variable "cpu" {
  type        = string 
  description = "value of cpu"
}

variable "desired_count" {
  type        = string
  description = "value of desired_count"
}

variable "container_port" {
  type        = string
  description = "value of container_port"
}

