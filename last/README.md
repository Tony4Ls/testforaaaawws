aws configure

nano ~/.aws/credentials

#
#

wget https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip 

unzip terraform_1.5.0_linux_amd64.zip 

sudo mv terraform /usr/local/bin/ 

terraform -v 

#
#

terraform init 

terraform plan 

terraform apply --auto-approve

terraform destroy --auto-approve

#
#

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

kubectl version --client

#
#

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

sudo mv /tmp/eksctl /usr/local/bin

eksctl version

#
#

git clone https://github.com/Tony4Ls/testforaaaawws.git
