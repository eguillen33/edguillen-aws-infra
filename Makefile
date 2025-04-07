TERRAFORM_DIR=terraform/environments/dev
TFVARS=$(TERRAFORM_DIR)/default.tfvars

init-dev:
	cd $(TERRAFORM_DIR) && terraform init

plan-dev:
	cd $(TERRAFORM_DIR) && terraform plan -var-file=$(TFVARS)

apply-dev:
	cd $(TERRAFORM_DIR) && terraform apply -auto-approve -var-file=$(TFVARS)

destroy-dev:
	cd $(TERRAFORM_DIR) && terraform destroy -auto-approve -var-file=$(TFVARS)

output-dev:
	cd $(TERRAFORM_DIR) && terraform output

format:
	find terraform/ -name "*.tf" -exec terraform fmt -check -diff {} +

