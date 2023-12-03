provider "cloudflare" {
  api_token = data.azurerm_key_vault_secret.cloudflare_token.value
}

# resource "cloudflare_record" "ingress" {
#   zone_id = data.azurerm_key_vault_secret.cloudflare_zone_id.value
#   name    = "notatnik"
#   value   = digitalocean_droplet.load_balancer[0].ipv4_address
#   type    = "A"
#   proxied = true
# }
# provider "kubectl" {
#     load_config_file       = true
#     host = digitalocean_kubernetes_cluster.inz-kubernetes.endpoint
# }
# data "kubernetes_ingress_v1" "example" {
#   metadata {
#     name = "argocd-server-ingress"
#     }
# }
resource "time_sleep" "wait_30_seconds" {
  depends_on = [helm_release.ingress-nginx-operator]

  create_duration = "45s"
}

data "kubernetes_resource" "ingress" {
  api_version = "v1"
  kind        = "Service"

  metadata {
    name      = "ingress-nginx-operator-controller"
    namespace = "ingress-nginx"
  }
  depends_on = [time_sleep.wait_30_seconds]
}

output "test" {
  value = data.kubernetes_resource.ingress.object.status.loadBalancer.ingress[0].ip
}

resource "cloudflare_record" "ingress_app" {
  zone_id = data.azurerm_key_vault_secret.cloudflare_zone_id.value
  name    = "notatnik"
  value   = data.kubernetes_resource.ingress.object.status.loadBalancer.ingress[0].ip
  type    = "A"
  proxied = true
}
resource "cloudflare_record" "ingress_argocd" {
  zone_id = data.azurerm_key_vault_secret.cloudflare_zone_id.value
  name    = "argocd"
  value   = data.kubernetes_resource.ingress.object.status.loadBalancer.ingress[0].ip
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "ingress_cdn" {
  zone_id = data.azurerm_key_vault_secret.cloudflare_zone_id.value
  name    = "cdn"
  value   = data.kubernetes_resource.ingress.object.status.loadBalancer.ingress[0].ip
  type    = "A"
  proxied = true
}
