#!/bin/bash
set -eu

wget https://get.helm.sh/helm-v3.0.0-rc.2-linux-amd64.tar.gz
tar zxfv helm-v3.0.0-rc.2-linux-amd64.tar.gz

mv linux-amd64/helm /usr/local/bin/helm

wget https://raw.githubusercontent.com/helm/charts/master/stable/jenkins/values.yaml -O jenkins-values.yaml

helm install stable/jenkins --name=jenkins --namespace=jenkins -f jenkins-values.yaml

kubectl -n jenkins get secret jenkins -o=jsonpath='{.data.jenkins-admin-password}' | base64 --decode

kubectl -n jenkins port-forward svc/jenkins 8080:8080