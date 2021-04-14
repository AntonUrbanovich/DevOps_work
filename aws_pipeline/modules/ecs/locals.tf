locals {
   esc_role_name         = "${var.resource_name}-ecs_role"
   container_definitions = file("/mnt/c/terraform-ecs/task-definition/nginx.json")
}