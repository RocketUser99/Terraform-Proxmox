# ------------------------------------------------------------
# Name: Tou Yang
# GitHub Link: https://github.com/RocketUser99
# 
# Template to provision a linux VM
# ------------------------------------------------------------

resource "proxmox_vm_qemu" "linux-vm" {

    # General VM info
    name =  "linux-vm"                          
    desc = "Deployed with terraform"
    vmid = 100                          # an id for the vm
    
    # Hardware
    cores = 4
    vcpus = 4
    cpu_type = "host"
    memory = 4096


    # Features 
    vm_state = "stopped"                # if set to running, vm will boot on creation 
    balloon = 4096
    agent = 1
    boot = "order=scsi0;ide0;net0"
    qemu_os = "l26"
    scsihw = "virtio-scsi-single"
    define_connection_info = "false"    # terraform ssh provision


    target_node = var.pvenode            

    # Display Block
    vga {
        type = "virtio"
    }

    # Network Block
    network {
        bridge = "vmbr0"
        model = "virtio"
        id = 0
        firewall = "true"
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
            ide0 {
                cdrom {
                    iso = var.Operating_system
                }
            }
        }

    }

}