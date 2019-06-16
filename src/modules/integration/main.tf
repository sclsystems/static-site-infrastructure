resource "aws_iam_role" "integration_role" {
  name_prefix        = "${var.domain_name}-"
  assume_role_policy = data.aws_iam_policy_document.integration_role_document.json
}

data "aws_iam_policy_document" "integration_role_document" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    principals {
      identifiers = ["codebuild.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy" "integration_role_policy" {
  role        = aws_iam_role.integration_role.name
  name_prefix = "${var.domain_name}-"

  policy = data.aws_iam_policy_document.integration_role_policy_document.json
}

data "aws_iam_policy_document" "integration_role_policy_document" {
  version = "2012-10-17"

  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation"
    ]
    resources = [
      "arn:aws:s3:::codepipeline-us-east-1-*"
    ]
    effect = "Allow"
  }

  statement {
    actions = [
      "logs:*",
      "cloudfront:CreateInvalidation"
    ]
    resources = [
      "*"
    ]
    effect = "Allow"
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation"
    ]
    resources = [
      var.s3_bucket.arn,
      "${var.s3_bucket.arn}/*"
    ]
    effect = "Allow"
  }

}

resource "aws_codebuild_project" "integration_code_build" {
  name         = var.project_name
  service_role = aws_iam_role.integration_role.arn

  artifacts {
    type                = "S3"
    encryption_disabled = true
    location            = var.s3_bucket.bucket
    name                = "/"
    namespace_type      = "NONE"
    packaging           = "NONE"
  }

  badge_enabled = true

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:2.0"
    type         = "LINUX_CONTAINER"

    environment_variable {
      name  = "CLOUDFRONT_DISTRIBUTION_ID"
      value = var.cloudfront_distribution_id
    }
  }

  source {
    type = "GITHUB"

    auth {
      type = "OAUTH"
    }

    buildspec           = var.buildspec_location
    location            = var.git_repository
    report_build_status = true
  }
}

resource "aws_codebuild_webhook" "integration_code_build_webhook" {
  project_name = aws_codebuild_project.integration_code_build.name

  filter_group {

    filter {
      type    = "HEAD_REF"
      pattern = "master"
    }

    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }
  }
}
