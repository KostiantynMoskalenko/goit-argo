output "argocd_server" {
  description = "ArgoCD server service"
  value       = "kubectl port-forward svc/argocd-server -n infra-tools 8080:443"
}
