# connect to aws use cloud9

aws configure

nano ~/.aws/credentials

# clone the files

git clone https://github.com/Tony4Ls/testforaaaawws.git

# install terraform

sudo yum install -y yum-utils

sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

sudo yum -y install terraform

terraform version

# terraform command

terraform init 

terraform plan 

terraform apply --auto-approve

terraform destroy --auto-approve

# install kubectl

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

kubectl version --client

# install eksctl

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

sudo mv /tmp/eksctl /usr/local/bin

eksctl version

# updata-kubeconfig

aws eks --region us-east-1 update-kubeconfig --name 4122-eks-cluster

# install helm

sudo yum install -y curl tar

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

chmod 700 get_helm.sh

./get_helm.sh

helm version

# install aws ebs csi driver

helm repo add aws-ebs-csi-driver https://kubernetes-sigs.github.io/aws-ebs-csi-driver

helm repo update

helm install aws-ebs-csi-driver aws-ebs-csi-driver/aws-ebs-csi-driver --namespace kube-system

kubectl get pods -n kube-system -l "app.kubernetes.io/name=aws-ebs-csi-driver,app.kubernetes.io/instance=aws-ebs-csi-driver"

# setup yaml

# if use aurora need to connect in aurora and create a moodle database first

kubectl apply -f pv.yaml

kubectl apply -f mariadb.yaml

kubectl apply -f moodle.yaml

