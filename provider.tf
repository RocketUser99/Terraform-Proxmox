# ------------------------------------------------------------
# Name: Tou Yang
# GitHub Link: https://github.com/RocketUser99
# 
# Template to add Proxmox as a provider
# ------------------------------------------------------------

terraform {
  
  required_version = ">= 0.36.4"
  
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}

# Proxmox use self-sign certificate so pm_tls_insecure is set to true

provider "proxmox" {
  pm_api_url = var.proxmox_url
  pm_api_token_id = var.tokenid
  pm_api_token_secret = var.terra_token
  pm_tls_insecure = true

}
