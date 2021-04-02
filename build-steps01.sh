#!/usr/bin/env bash

echo "delete clusters"

#minikube delete -p target-k8s
#minikube delete -p argocd-k8s

echo "Create the clusters"

minikube start -p target-k8s
minikube start -p argocd-k8s
minikube addons -p argocd-k8s enable ingress

echo "Set the Argocd cluster as default"

kubectl config use-context argocd-k8s

echo "Install Argocd in the cluster"

kubectl create namespace argocd
kubectl apply -n argocd -f install.yml

echo "Listing pods"
until (kubectl get pods -n argocd | grep -c Running) | grep -m 1 "5"; do : ; done
