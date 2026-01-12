output "argocd_server" {
  description = "ArgoCD server service"
  value       = kubernetes_namespace.argo.metadata[0].name
}
