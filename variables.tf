# ------------------------------------------------------------
# Name: Tou Yang
# GitHub Link: https://github.com/RocketUser99
# 
# Template to provision a window VM
# ------------------------------------------------------------


# Format: "aaaaaaaaa-bbb-cccc-dddd-ef0123456789"
variable "terra_token" {
    description = "User Terraform Token"
    type = string
    sensitive = true
}

# Format: "https://sever-ip/api2/json"
# Must end with /api2/json to connect to proxmox api

variable "proxmox_url" {
    description = "URL to Proxmox api (aka ip address of proxmox)"
    type = string
    sensitive = true
}

# Format: username@type!token-ID" 
# Example:
#   tokenid = "terraform-prov@pve!terram" 
# ps: the token ID is the name you give to it when creating the token (TokenID == Token Name)

variable "tokenid" {
    description = "user and token name"
    type = string
    sensitive = true
}

variable "ubuntu_operating_system" {
  description = "iso file name"
  type = string
  sensitive = true
}

variable "pvenode" {
  description = "name of the node to deploy to"
  type = string
  sensitive = true
}

variable "win_virt_driver" {
  description = "window virtio drivers"
  type = string
  sensitive = true
}

variable "win_operating_system" {
  description = "window iso"
  type = string
  sensitive = true
}

variable "user_username" {
  description = "name for the ssh user"
  type = string
  sensitive = true
}

variable "user_password" {
  description = "password for user"
  type = string
  sensitive = true
}

variable "ssh_private_key_value" {
  description = "id_rsa.pub"
  type = string
  sensitive = true
}

variable "static_ip_config_info" {
  description = "static ip for cloud init vm"
  type = string
  sensitive = true
}


variable "file_path" {
  description = "file path of config stored on the proxmox server"
  type = string
  sensitive = true
}
