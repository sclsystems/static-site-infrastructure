# Static Site Infrastructure

For use as a Git Module within static site projects

## Setup

Note: Make sure you edit the `terraform.tfvars` file with appropriate values

```bash
terraform init

cd platform/src
terraform apply \
    --var-file ../../app/terraform.tfvars
```
