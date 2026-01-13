provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}

data "aws_eks_cluster" "eks" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "eks" {
  name = var.cluster_name
}

resource "kubernetes_namespace" "argo" {
  metadata {
    name = var.argocd_namespace
  }
}

resource "helm_release" "argo" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = kubernetes_namespace.argo.metadata[0].name
  version    = var.argocd_chart_version
  create_namespace = true
  values = [file("${path.module}/values/argocd-values.yaml")]
}

resource "kubernetes_manifest" "namespaces_appset" {
 manifest = {
  apiVersion = "argoproj.io/v1alpha1"
  kind    = "ApplicationSet"
  metadata = {
   name   = "namespaces-appset"
   namespace = var.argocd_namespace
  }
  spec = {
   generators = [{
    git = {
     repoURL   = var.app_repo_url
     revision  = var.app_repo_branch
     directories = [{ path = "namespaces/*" }]
    }
   }]
   template = {
    metadata = {
     name   = "ns-{{path.basename}}"
     namespace = var.argocd_namespace
    }
    spec = {
     project = "default"
     source = {
      repoURL    = var.app_repo_url
      targetRevision = var.app_repo_branch
      path      = "{{path}}"
      directory = { recurse = true } # читати підкаталоги (apps/, configmaps/, secrets/)
     }
     destination = {
      server  = "https://kubernetes.default.svc"
      namespace = "{{path.basename}}" # application / infra-tools / ...
     }
     syncPolicy = {
      automated  = { prune = true, selfHeal = true }
      syncOptions = ["CreateNamespace=true"]
     }
     revisionHistoryLimit = 2
    }
   }
  }
 }
 depends_on = [helm_release.argo]
}
