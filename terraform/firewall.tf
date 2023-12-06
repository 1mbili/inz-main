provider "cloudflare" {
  api_token = data.azurerm_key_vault_secret.cloudflare_token.value
}

data "kubernetes_resource" "ingress" {
  api_version = "v1"
  kind        = "Service"

  metadata {
    name      = "ingress-nginx-operator-controller"
    namespace = "ingress-nginx"
  }
  depends_on = [helm_release.ingress-nginx-operator]
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
