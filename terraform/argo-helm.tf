provider "helm" {
  kubernetes {
    host                   = digitalocean_kubernetes_cluster.inz-kubernetes.endpoint
    cluster_ca_certificate = base64decode(digitalocean_kubernetes_cluster.inz-kubernetes.kube_config[0].cluster_ca_certificate)
    token                  = digitalocean_kubernetes_cluster.inz-kubernetes.kube_config[0].token
  }
}
provider "kubernetes" {
  host  = digitalocean_kubernetes_cluster.inz-kubernetes.endpoint
  token = digitalocean_kubernetes_cluster.inz-kubernetes.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.inz-kubernetes.kube_config[0].cluster_ca_certificate
  )
}

resource "helm_release" "argocd" {
  name             = "argocd-helm"
  namespace        = "argocd"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

}

resource "helm_release" "ingress-nginx-operator" {
  name             = "ingress-nginx-operator"
  namespace        = "ingress-nginx"
  create_namespace = true

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  set {
    name  = "controller.metrics.enabled"
    value = true
  }
  set {
    name  = "controller.metrics.serviceMonitor.enabled"
    value = true
  }
  set {
    name  = "controller.metrics.serviceMonitor.additionalLabels.release"
    value = "prometheus"
  }
  set {
    name  = "controller.metrics.serviceMonitor.enabled"
    value = true
  }
  set {
    name  = "controller.metrics.serviceMonitor.additionalLabels.release"
    value = "prometheus"
  }
  depends_on = [ 
    helm_release.prometheus-operator
   ]
}

resource "helm_release" "external-secrets" {
  name             = "external-secrets"
  namespace        = "external-secrets"
  create_namespace = true

  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"
}

resource "helm_release" "prometheus-operator" {
  name             = "prometheus"
  namespace        = "prometheus"
  create_namespace = true

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  set {
    name  = "prometheus.prometheusSpec.podMonitorSelectorNilUsesHelmValues"
    value = false
  }
  set {
    name  = "prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues"
    value = false
  }

}

