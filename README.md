# Static Site Infrastructure

For use as a Git Module within static site projects

## Setup

Note: Make sure you edit the `terraform.tfvars` file with appropriate values

Note: Make sure you edit `workspace.tf` for the appropriate Terraform Remote

```bash
cd platform/src

terraform init

terraform apply \
    --var-file ../../app/terraform.tfvars
```
