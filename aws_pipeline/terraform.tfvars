iam_policy_arn   = [
  "arn:aws:iam::aws:policy/AWSCodeStarFullAccess",
  "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess",
  "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser",
  "arn:aws:iam::aws:policy/AmazonElasticContainerRegistryPublicFullAccess",
  "arn:aws:iam::aws:policy/AmazonElasticContainerRegistryPublicPowerUser",
  "arn:aws:iam::aws:policy/service-role/AWSCodeStarServiceRole"
  ]

resource_name    = "nginx"
project_name     = "nginx"
fullRepositoryId = "impalla215/develops_aws"
branchName       = "develop"
bucket_name      = "pipeline_bucket"
buildspec        = "buildspec.yml"
cluster_name     = "nginx_cluster"
service_name     = "nginx_service"
memory           = "512"
cpu              = "256"
desired_count    = "1"
container_port   = "80"
