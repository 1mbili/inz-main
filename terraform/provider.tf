terraform {
  required_version = ">= 1.0.6"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.61.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
  backend "azurerm" {
    storage_account_name = "csb10032002f1976f3a"
    container_name       = "terraform"
    key                  = "prod.terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
