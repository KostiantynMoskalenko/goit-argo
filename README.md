## Preconditions
The clustr created on previos steps. See https://github.com/KostiantynMoskalenko/lesson-5-6

## MLflow Deployment with ArgoCD on EKS:
```
cd argocd
```

## Terrafrm initialization for ArgoCD:
```
   terraform init
   terraform plan
   terraform apply
```

## Pods checkinf:

```
kubectl get pods -n infra-tools
```

## Add necessary changes in "main.tf" file
Start from "resource "kubernetes_manifest" "namespaces_appset"....." and below in "main.tf" file.


## Update and deploy terrafom:

```
terraform init -reconfigure  
terraform plan
terraform apply
```

## Force update of ApplicationSet:

```
kubectl -n infra-tools annotate applicationset namespaces-appset argocd.argoproj.io/application-set-refresh=force --overwrite
```

## Check applications for every folder:

```
kubectl -n infra-tools get applications.argoproj.io
```

## Access getting for ArgoCD UI:
1. Get password:
   ```
   $encodedPassword = kubectl -n infra-tools get secret argocd-initial-admin-secret -o jsonpath='{.data.password}'
   [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($encodedPassword))
   ```
2. Port forwarding:
   ```   
   kubectl port-forward svc/argocd-server -n infra-tools 8080:80
   ```
3. Open `http://localhost:8080` link in browser, log in with `admin` and the password from the step 1.

## Make and deploy changes in "application.yaml" file for work with mlflow.

## Check application in UI ArgoCD in browser (localhost:8080).
