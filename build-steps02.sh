#!/usr/bin/env bash

./build-steps01.sh

kubectl get pods -n argocd -w

kubectl port-forward svc/argocd-server -n argocd 8080:443

kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2

#argocd-server-69678b4f65-52wj6

echo "Using ArgoCD"ch

	argocd login --insecure localhost:8080

	argocd account update-password

 	argocd cluster add target-k8s


echo "Install demo Add App using ArgoCD"

export ARGOCD_OPTS='--port-forward-namespace argocd'

export MINIKUBE_IP=https://$(minikube ip -p target-k8s):8443

argocd app create spring-petclinic --repo https://github.com/andrefelixbr/argocd-getting-started.git --path . --dest-server $MINIKUBE_IP --dest-namespace default

argocd app list

argocd app get spring-petclinic

argocd app sync spring-petclinic

kubectl config use-context target-k8s

kubectl port-forward svc/spring-petclinic -n default 9090:8080



## kubectl apply -f ./ingress-k8s.yaml set --enable-ssl-passthrough

kubectl annotate ing nginx-ingress-controller kubernetes.io/tls-acme="true"


echo "$(minikube -p target-k8s ip)"
echo "$(minikube -p argocd-k8s ip)"




# http://localhost:8080
# admin
# argocd-server-5d7b59fcd-sk7g7

# https://wiki-engr.mcp-services.net/display/CIDMS/Analysis+of+Automated+Deployment+Tooling
# https://wiki-engr.mcp-services.net/display/CIDMS/2021-03-02+Nebula+Development+Meeting+-+agenda+and+notes
# https://wiki-engr.mcp-services.net/display/CIDMS/2021-03-16+Nebula+Development+Meeting+-+agenda+and+notes
# https://wiki-engr.mcp-services.net/display/CIDMS/Nebula+-+Argo+CD
