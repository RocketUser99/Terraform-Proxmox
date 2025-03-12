# ------------------------------------------------------------
# Name: Tou Yang
# GitHub Link: https://github.com/RocketUser99
# 
# Template to provision a linux VM with cloud provision
# ------------------------------------------------------------


# I couldn't get this cloud init drive to work properly 
# You must upload the config file to your proxmox server manually
# resource "proxmox_cloud_init_disk" "cloud_init_drive" {
#     name = "cloud_init_drive_example"
#     pve_node = var.pvenode
#     storage = var.iso_storage_name

#     user_data = <<-EOT
# ${file(var.file_path)}
# EOT

# }

resource "proxmox_vm_qemu" "linux-cloud-init" {
    
    # node of deployment
    target_node = var.pvenode  

    # General VM info
    name =  "linux-cloud-init"                          
    desc = "Deployed with terraform"
    vmid = 103                          # an id for the vm
    

    # Cloud config
    os_type = "ubuntu"
    clone = "ubuntu-cloud-template"
    ipconfig0 = var.static_ip_config_info
    ciupgrade  = "true"                # Auto Update

    # Automatic config using config file
    cicustom = var.file_path

    # Manual config
    # define_connection_info = "true"    # terraform ssh provision
    # ciuser = var.user_username
    # cipassword = var.user_password
    # ssh_private_key = var.ssh_private_key_value 


    # Hardware
    cores = 4
    vcpus = 4
    cpu_type = "host"
    memory = 4096


    # Features 
    vm_state = "stopped"                # if set to running, vm will boot on creation 
    balloon = 4096
    agent = 1
    boot = "order=scsi0"
    qemu_os = "l26"
    scsihw = "virtio-scsi-single"


    # Display Block
    serial {
        id = 0
    }

    # Network Block
    network {
        bridge = "vmbr0"
        model = "virtio"
        id = 0
        firewall = "true"

        # Optional 
        # macaddr = ""
    }

    # Disks
    disks {
        scsi {
            scsi0 {
                disk {
                    backup = "false"                # For testing purposes backup is false
                    cache = "none"
                    size = "30G"
                    storage = "local-lvm"
                    iothread = "true"
                }
            }
        }
        
        ide {
            # Cloud init drive not working
            # Will keep the required code here in case its needed in the future
            # ide0 {
            #     cdrom {
            #         iso = "${proxmox_cloud_init_disk.cloud_init_drive.id}"
            #     }
            # }
            ide1 {
                cloudinit {
                    storage = "local-lvm"
                }
            }
        }
    }

}