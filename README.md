# Static Site Infrastructure

For use as a Git Module within static site projects

## Applying Changes

1. Add this repo as a Git Module to your static site repo

2. Add a `terraform.auto.tfvars` file and include the following variables

```hcl-terraform
aws_region              = "us-east-1"
domain_name             = "scl.systems"
project_name            = "scl-systems-static-site"
hosted_zone_id          = "ABCDEF1234566789"
git_repository          = "https://github.com/sclsystems/static-site-infrastructure.git"
buildspec_location      = ".cicd/buildspec.yaml"
cloudfront_refer_secret = "my_secret"
```

4. Deploy the cluster using terraform

```bash
make terraform-plan
make terraform-apply
```
