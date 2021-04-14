resource "aws_codepipeline" "codepipeline" {
  name     = local.pipeline_name
  role_arn = aws_iam_role.codepipeline.arn

  artifact_store {
    location = aws_s3_bucket.pipeline_bucket123.bucket
    type     = "S3"
  

  encryption_key {
      id   = data.aws_kms_alias.s3kmskey.arn
      type = "KMS"
  }

  }
  stage {
    name = "Source"
  
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = data.aws_codestarconnections_connection.git_hub.arn
        FullRepositoryId = var.fullRepositoryId
        BranchName       = var.branchName
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = local.codebuild_name
      }
    }
  }
    stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ClusterName = var.cluster_name
        ServiceName = var.service_name
      }
    }
  }
}




data "aws_codestarconnections_connection" "git_hub" {
  arn = "arn:aws:codestar-connections:us-east-2:825035861533:connection/bc54981a-5a6e-411f-b1b7-40b8d863ad8e"
}

resource "aws_s3_bucket" "pipeline_bucket123" {
  bucket = "code-pipeline-bucket-my-bucket"
  acl    = "private"

  tags = {
    Name        = var.bucket_name
    Environment = "Dev"
  }
}


data "aws_kms_alias" "s3kmskey" {
  name = "alias/aws/s3"
}

resource "aws_iam_role" "codepipeline" {
  name = local.pipeline_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = local.pipeline_policy_name
  role   = aws_iam_role.codepipeline.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect":"Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetBucketVersioning",
        "s3:PutObject"
      ],
      "Resource": [
        "${aws_s3_bucket.pipeline_bucket123.arn}",
        "${aws_s3_bucket.pipeline_bucket123.arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attach" {
  role       = aws_iam_role.codepipeline.name
  count      = length(var.iam_policy_arn)
  policy_arn = var.iam_policy_arn[count.index]
}



