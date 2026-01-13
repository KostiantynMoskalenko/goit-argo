aws eks update-kubeconfig --region us-east-1 --name cluster1

# MLflow Deployment with ArgoCD on EKS
# For using 'Secret' run:
```
cd argocd
#cd values	
#kubectl apply -f secret.yaml

#cd..
```
#kubectl create namespace infra-tools
#kubectl apply -n infra-tools -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

## Deploy ArgoCD with terraform:
```
   terraform init
   terraform plan
   terraform apply
```
Force update of ApplicationSet
kubectl -n infra-tools annotate applicationset namespaces-appset argocd.argoproj.io/application-set-refresh=force --overwrite

Check applications for every folder:
kubectl -n infra-tools get applications.argoproj.io

Check pods in `infra-tools` namespace:
```
kubectl get pods -n infra-tools
```

## Access ArgoCD UI
1. Get password:
   In powershell:
   ```
   $encodedPassword = kubectl -n infra-tools get secret argocd-initial-admin-secret -o jsonpath='{.data.password}'
   [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($encodedPassword))
   ```
2. Port forwarding:
   In powershell:
   ```   
   kubectl port-forward svc/argocd-server -n infra-tools 8080:80
   ```
3. Open `http://localhost:8080` link in browser, log in with `admin` and the password from the step 1.

## Verify MLflow Deployment
Check pods in `mlflow` namespace:

kubectl get pods -n mlflow

## Git repository with application.yaml
Application and Helm chart: https://github.com/KostiantynMoskalenko/mlflow-helm.git
Contains application.yaml, Chart.yaml, values.yaml.
