terraform {
  required_version = "1.11.2"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "3.0.0-pre2"
    }
  }
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}

variable "nginx-ingress-controller-chart-version" {
  description = "External-dns chart version"
  type        = string
}

resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress-controller"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
  version    = var.nginx-ingress-controller-chart-version

  set = [
    {
      name  = "service.type"
      value = "ClusterIP"
    }
  ]
}
