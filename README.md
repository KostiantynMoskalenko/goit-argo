# MLflow Deployment with ArgoCD on EKS

## Deploy ArgoCD with terraform:
```
   terraform init
   terraform plan
   terraform apply
```

## Verify ArgoCD
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
