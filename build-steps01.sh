#!/usr/bin/env bash

echo "delete clusters"

minikube delete -p target-k8s
minikube delete -p argocd-k8s

echo "Create the clusters"

minikube start -p target-k8s
minikube start -p argocd-k8s
minikube addons enable ingress

echo "Set the argocd cluster as default"

kubectl config use-context argocd-k8s

echo "Install Argocd in the cluster"

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
