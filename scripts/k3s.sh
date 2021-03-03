#!/bin/bash

# Install k3s
curl -sfL https://get.k3s.io | sh -s - --docker
mkdir /root/.kube
kubectl config view --raw > /root/.kube/config
chmod 600 /root/.kube/config
