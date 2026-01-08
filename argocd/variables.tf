variable "region" {
  type    = string
  default = "us-east-1"
}

variable "cluster_name" {
  type    = string
  default = "cluster1"
}

variable "argocd_namespace" {
 description = "Namespace for Argo CD"
 type    = string
 default   = "infra-tools"
}

variable "argocd_chart_version" {
 description = "Helm-chart version Argo CD"
 type    = string
 default   = "v7.7.5"
}

variable "app_repo_url" {
 description = "Public Git-repo with manifests"
 type    = string
 default   = "https://github.com/KostiantynMoskalenko/goit-argo.git"
}

variable "app_repo_branch" {
 description = "Branch"
 type    = string
 default   = "main"
}