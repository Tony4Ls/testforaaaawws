wget https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip \

unzip terraform_1.5.0_linux_amd64.zip \

sudo mv terraform /usr/local/bin/ \

terraform -v \

terraform init \
terraform plan \
terraform apply \
