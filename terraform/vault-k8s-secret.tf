variable "ClientID" {
  type = string
}

variable "ClientSecret" {
  type = string
}

resource "kubernetes_secret" "azure-sp-creds" {
  metadata {
    name = "azure-secret-sp"
    namespace = "default"
  }
  data = {
    "ClientID" = "${var.ClientID}"
    "ClientSecret" = "${var.ClientSecret}"
  }
}