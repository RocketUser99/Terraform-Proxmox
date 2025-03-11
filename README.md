# Terraform-Proxmox

Simplify and automate your proxmox deployment with Terraform! 

# Requirement

* Proxmox server
* A machine to install Terraform (We will be using Ubuntu in this demo)

# Getting Started


Run the following command to install Terraform on Ubuntu:

```
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

Nice! Now we have Terraform installed.

Follow this link here to create a provisioning account for your proxmox server and generate a token to connect to your proxmox server for this demo. Due to insufficient permission and to simplify things, we will directly use the root account for this demo. It's recommended to setup proxmox on a vm and test your deployment there.

Now is a great time to upload any iso files that you want to use to your proxmox server. If you don't plan to deploy a specific vm in this demo, make sure to remove or comment out .tf files for that specific vm.

# Hiding the secrets 
 
Cloud providers offer ways to store you sensitive data. Since, this is a demo, we will be storing confidential information to our current working directory.
Once you have your token, create a secret.tfvars file to store your login credentials. A sample secret.tfvars is provided. Just make sure you remove the trailing "example" from the file name. 

# Deployment

If you had not already do so, clone this repo to your desktop and open your terminal to this repo. To initalize Terraform inside of this repo, run:

```
Terraform init
```

Once it initialized, run:

```
terraform plan -var-file="secret.tfvars"
```

Terraform will tell us what it will create. If there is anything that Terraform doesn't know it will throw out a error at this point.

ex output:
```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # proxmox_vm_qemu.linux-vm will be created
  + resource "proxmox_vm_qemu" "linux-vm" {
      + additional_wait        = 5
      + agent                  = 1
      + automatic_reboot       = true
      + balloon                = 4096
      + bios                   = "seabios"
      + boot                   = "order=scsi0;ide0;net0"
      + bootdisk               = (known after apply)
      + ciupgrade              = false
      + clone_wait             = 10
      + cores                  = 4
      + cpu_type               = "host"
      + default_ipv4_address   = (known after apply)
      + default_ipv6_address   = (known after apply)
      + define_connection_info = false
      + desc                   = "Deployed with terraform"
      + force_create           = false
      + full_clone             = true
      + hotplug                = "network,disk,usb"
      + id                     = (known after apply)
      + kvm                    = true
      + linked_vmid            = (known after apply)
      + memory                 = 4096
      + name                   = "linux-vm"
      + onboot                 = false
      + protection             = false
      + qemu_os                = "l26"
      + reboot_required        = (known after apply)
      + scsihw                 = "virtio-scsi-single"
      + skip_ipv4              = false
      + skip_ipv6              = false
      + sockets                = 1
      + ssh_host               = (known after apply)
      + ssh_port               = (known after apply)
      + tablet                 = true
      + tags                   = (known after apply)
      + target_node            = (sensitive value)
      + unused_disk            = (known after apply)
      + vcpus                  = 4
      + vm_state               = "stopped"
      + vmid                   = 100

      + disks {
          + ide {
              + ide0 {
                  + cdrom {
                      + iso = (sensitive value)
                    }
                }
            }
          + scsi {
              + scsi0 {
                  + disk {
                      + backup               = false
                      + cache                = "none"
                      + format               = "raw"
                      + id                   = (known after apply)
                      + iops_r_burst         = 0
                      + iops_r_burst_length  = 0
                      + iops_r_concurrent    = 0
                      + iops_wr_burst        = 0
                      + iops_wr_burst_length = 0
                      + iops_wr_concurrent   = 0
                      + iothread             = true
                      + linked_disk_id       = (known after apply)
                      + mbps_r_burst         = 0
                      + mbps_r_concurrent    = 0
                      + mbps_wr_burst        = 0
                      + mbps_wr_concurrent   = 0
                      + size                 = "30G"
                      + storage              = "local-lvm"
                    }
                }
            }
        }

      + network {
          + bridge    = "vmbr0"
          + firewall  = true
          + id        = 0
          + link_down = false
          + macaddr   = (known after apply)
          + model     = "virtio"
        }

      + smbios (known after apply)

      + vga {
          + type = "virtio"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

To start the deployment, run the following command and type yes when prompted:

```
terraform apply -var-file="secret.tfvars"
```

To remove the deployment, run the following command and type yes when prompted:
```
terraform destroy -var-file="secret.tfvars"
```
Good Job! You learned how to automate deployment in Proxmox with Terraform

# Final Thoughts

Learning Terraform was challenging! When I first saw Terraform codes, the language seems complicated and so different from low leveling programming languages like C, at least that was how I felt. However, after I started coding and getting comfortable with it, Terraform wasn't as hard as I initally thought it was. It was so EASY!!! Aside from spending hours on reading documentation on Proxmox and Terraform, the most complicated thing was the proccess of figuring out what you want and putting that into code so that Terraform knows what you want.  

Everyone's experience with Terraform will be different. Others may find it simple to understand while the rest will struggle a "bit" but learning Terraform was a fun and exciting.

# Reference Link

For more details, check out the official [Terraform](https://k3s.io/) and [VM Qemu Resource](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/resources/vm_qemu)  webpage.

Privilege Separation?? Check [this](https://github.com/Telmate/terraform-provider-proxmox/issues/784) out