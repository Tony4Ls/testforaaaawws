wget https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip 

unzip terraform_1.5.0_linux_amd64.zip 

sudo mv terraform /usr/local/bin/ 

terraform -v 

terraform init 
terraform plan 
terraform apply 
terraform destroy

#
#
#
#
#
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

kubectl version --client
