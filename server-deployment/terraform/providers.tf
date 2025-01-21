provider "helm" {
  kubernetes {
    config_path = var.config_filename
    config_context = "kind-${var.cluster_name}"
  }
}

provider "kubernetes" {
  config_path    = var.config_filename
  config_context = "kind-${var.cluster_name}"
}

