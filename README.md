# MLflow Deployment with ArgoCD on EKS

## Deploy ArgoCD
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
   ```powershell
   $encodedPassword = kubectl -n infra-tools get secret argocd-initial-admin-secret -o jsonpath='{.data.password}'
   [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($encodedPassword))
   ```
3. Open `http://localhost:8080`, log in with `admin` and the password.

## Verify MLflow Deployment
Check pods in `mlflow` namespace:
```
kubectl get pods -n mlflow
```

## Git Repository
- Application and Helm chart: `https://github.com/TensAurpheus/mlflow-helm.git`
- Contains `application.yaml`, `Chart.yaml`, `values.yaml`.