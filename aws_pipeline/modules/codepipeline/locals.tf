locals {
  pipeline_name         = "${var.project_name}-pipeline"
  stage_name            = "${var.resource_name}-"
  codebuild_name        = "${var.project_name}-code_build"
  pipeline_role_name    = "${var.resource_name}-pipeline_role"
  pipeline_policy_name  = "${var.resource_name}-pipeline_policy"
  codebuild_role_name   = "${var.resource_name}-codebuild_role"
  codebuild_policy_name = "${var.resource_name}-codebuild_policy"
}