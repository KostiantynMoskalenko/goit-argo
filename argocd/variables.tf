variable "region" {
  type    = string
  default = "us-east-1"
}

variable "cluster_name" {
  type    = string
  default = "cluster1"
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