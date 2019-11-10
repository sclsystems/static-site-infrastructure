TERRAFORM=terraform
RM=rm

terraform-plan:
	$(TERRAFORM) init
	$(TERRAFORM) plan --out changes
.PHONY: terraform-plan

terraform-apply:
	$(TERRAFORM) init
	$(TERRAFORM) apply changes
	$(RM) changes
.PHONY: terraform-apply
