# argocd-getting-started
* This repo is meant to be used with a blog post for getting started with Argo CD [link pending].
* Argo will read the Kubernetes manifest files contained here to deploy a demo application to Kubernetes.
* Optionally, a Dockerfile is included if readers would like to package their own spring-petclinic instance for further playing




# See the cluster's resources 
k get pod -n kube-system


kubectl get ns

```
NAME                   STATUS   AGE
argocd                 Active   132m
default                Active   134m
kube-node-lease        Active   134m
kube-public            Active   134m
kube-system            Active   134m
kubernetes-dashboard   Active   134m
```
