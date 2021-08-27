# gcp
terraform init -var-file=state.config
terraform plan -var-file=account.tfvars -out=newfile_of_plan
terraform apply -var-file=account.tfvars -state-out=newfile_of_plan
