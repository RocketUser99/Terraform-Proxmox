# ------------------------------------------------------------
# Name: Tou Yang
# GitHub Link: https://github.com/RocketUser99
# 
# Template to provision a window VM
# ------------------------------------------------------------

resource "proxmox_vm_qemu" "window-vm" {

    ## ***Important ***
    # TPM state needs to be added manually, machine type needs to be changed manually
    # I recommend cloning from a template

    # node of deployment
    target_node = var.pvenode  

    # General VM info
    name =  "window-vm"                          
    desc = "Deployed with terraform"
    vmid = 101                          # an id for the vm 

    # **note: terraform won't increment the vmid, if deploying vm with same vmid
    
    # Hardware
    cores = 4
    vcpus = 4
    cpu_type = "host"
    memory = 8192
    bios = "ovmf"


    # Features 
    vm_state = "stopped"  # if set to running, vm will boot on creation 
    balloon = 8192
    agent = 1
    boot = "order=virtio0;ide0;net0"
    qemu_os = "win11"
    scsihw = "virtio-scsi-single"
    define_connection_info = "false"
  
    vga {
        type = "virtio"
    }

    network {
        bridge = "vmbr0"
        model = "virtio"
        id = 0
        firewall = "true"
    }

    efidisk {
        efitype = "4m"
        storage = "local-lvm"
    }

    # tpmdisk{
    #     efitype = "4m"
    #     storage = "local-lvm"
    # }

    # Disks
    disks {
        virtio {
            virtio0 {
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
                    iso = var.win_operating_system
                }
            }

            ide1 {
                cdrom {
                    iso = var.win_virt_driver
                }
            }
        }

    }


}