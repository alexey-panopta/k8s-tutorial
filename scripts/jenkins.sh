#!/bin/bash

# Setup kube config
sudo chown vagrant /etc/rancher/k3s/k3s.yaml
mkdir ~/.kube
sudo kubectl config view --raw > ~/.kube/config
chmod 600 ~/.kube/config

# Install helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod +x get_helm.sh
./get_helm.sh
helm repo add jenkins https://charts.jenkins.io
helm repo update

# Install jenkins
kubectl create ns jenkins
helm install jenkins -n jenkins -f jenkins/values.yaml jenkins/jenkins

# Creating ingress
kubectl apply -f jenkins/ingress.yaml
