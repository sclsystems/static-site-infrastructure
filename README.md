# Static Site Infrastructure

For use as a Git Module within static site projects

## Applying Changes

1. Add this repo as a Git Module to your static site repo

2. Add a `terraform.auto.tfvars` file and include the following variables

```hcl-terraform
domain_name = {
  domain         = "ABCDEF1234566789"
  hosted_zone_id = "scl.systems"
}
mirror_domains = [{
  domain         = "ABCDEF1234566780"
  hosted_zone_id = "example.com"
}]
project_name            = "scl-systems-static-site"
git_repository          = "https://github.com/sclsystems/static-site-infrastructure.git"
buildspec_location      = ".cicd/buildspec.yaml"
cloudfront_refer_secret = "my_secret"
```

4. Deploy the cluster using terraform

```bash
make terraform-pla
make terraform-apply
```
