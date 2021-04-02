#!/usr/bin/env bash

kubectl port-forward svc/argocd-server -n argocd 8080:443 &

export ADM_PASSWORD=$(kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2)

echo 'Adm Password: '$ADM_PASSWORD

echo "Using ArgoCD"

	argocd login --insecure --username admin --password $ADM_PASSWORD localhost:8080

	argocd account update-password --current-password $ADM_PASSWORD  --new-password teco01

 	argocd cluster add target-k8s

echo "Install demo Add App using ArgoCD"

export ARGOCD_OPTS='--port-forward-namespace argocd'

export MINIKUBE_IP=https://$(minikube ip -p target-k8s):8443

# argocd app create spring-petclinic --repo https://github.com/andrefelixbr/argocd-getting-started.git --path . --dest-server $MINIKUBE_IP --dest-namespace default
argocd app create spring-petclinic --repo https://github.com/anthonyvetter/argocd-getting-started.git --path . --dest-server $MINIKUBE_IP --dest-namespace default

argocd app list

argocd app get spring-petclinic

argocd app sync spring-petclinic

echo "Wait for application be ready."
until (argocd app get spring-petclinic | grep -c Healthy) | grep -m 1 "3"; do : ; done

kubectl config use-context target-k8s

kubectl port-forward svc/spring-petclinic -n default 9090:8080 &

kubectl config use-context argocd-k8s

kubectl apply -f ./ingress/argocd-server-ingress.yml
kubectl apply -f ./ingress/argocd-server-ingress-grpc.yml

echo "target-k8s -> "$(minikube -p target-k8s ip)
echo "arogcd-k8s -> "$(minikube -p argocd-k8s ip)

