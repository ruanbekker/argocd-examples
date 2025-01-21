module "kubernetes" {
  source  = "git::https://github.com/ruanbekker/terraform-kubernetes-kind-module.git?ref=main"

  cluster_name    = var.cluster_name
  workers         = 1
  cluster_version = "v1.27.16"
  kubeconfig_file = var.config_filename
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "oci://ghcr.io/argoproj/argo-helm"
  chart      = "argo-cd"
  version    = "7.7.15"
  namespace  = "argocd"
  create_namespace = true

  depends_on = [ module.kubernetes ]
}

