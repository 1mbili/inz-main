terraform {
  required_version = ">= 1.5.6"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.79.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
  backend "azurerm" {
    storage_account_name = "csb10032002f1976f3a"
    container_name       = "terraform"
    key                  = "prod.terraform.tfstate"
  }
}

provider "digitalocean" {
  token = data.azurerm_key_vault_secret.digitalocean_token.value
}
