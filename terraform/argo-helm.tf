provider "helm" {
    kubernetes {
    host = digitalocean_kubernetes_cluster.inz-kubernetes.endpoint
    cluster_ca_certificate = "${base64decode(digitalocean_kubernetes_cluster.inz-kubernetes.kube_config.0.cluster_ca_certificate)}"
    token = digitalocean_kubernetes_cluster.inz-kubernetes.kube_config[0].token
    }
}
provider "kubernetes" {
  host    = digitalocean_kubernetes_cluster.inz-kubernetes.endpoint
  token   = digitalocean_kubernetes_cluster.inz-kubernetes.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.inz-kubernetes.kube_config[0].cluster_ca_certificate
  )
}

resource "helm_release" "argocd" {
  name       = "argocd-helm"
  namespace  = "argocd"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

}