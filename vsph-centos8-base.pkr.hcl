locals {
  packerStartTime = formatdate("YYYYMMDD-hhmm", timestamp())
  #build_name = "packer-windows2019-base-${local.packerStartTime}"
}

variable "cpu_count" {
  type    = string
  default = "2"
}

variable "disk_size" {
  type    = string
  default = "51200"
}

variable "memory_size" {
  type    = string
  default = "8192"
}

variable "vc_centos7iso" {
  type    = string
}

variable "vc_toolsiso" {
  type    = string
}

variable "vm_notes" {
  type    = string
  default = "Packer template provisioned on DATE"
}

variable "ssh_username" {
  type    = string
  default = "vagrant"
}

variable "ssh_password" {
  type    = string
  default = "vagrant"
}

variable "vc_server" {
  type = string
}
variable "vc_username" {
  type = string
}
variable "vc_password" {
  type = string
}
variable "vc_cluster" {
  type = string
}
variable "vc_folder" {
  type = string
}
variable "vc_host" {
  type = string
}
variable "vc_resource_pool" {
  type = string
}
variable "vc_datastore" {
  type = string
}
variable "vc_network" {
  type = string
}
variable "build_name" {
  type = string
  default = "packer-vsph-centos7-base"
}

source "vsphere-iso" "centos7" {
  # HTTP Configuration
  #http_directory        = "${var.http_dir}"
  #http_port_max         = "${var.http_port}"
  #http_port_min         = "${var.http_port}"
 
  # Boot Command
  boot_command = ["<wait5><tab> text ks=hd:fd0:/ks.cfg<enter><wait5><esc>"]

  # Floppy Configuration
  floppy_files          = ["kickstart/centos7/ks.cfg"]

  # Connection Configuration
  vcenter_server        = var.vc_server
  username              = var.vc_username
  password              = var.vc_password
  insecure_connection   = "true"

  # Hardware Configuration
  CPUs                  = var.cpu_count
  RAM                   = var.memory_size
  RAM_reserve_all       = false
  firmware              = "bios"

  # Location Configuration
  vm_name               = "${var.build_name}"
  folder                = "Templates"
  cluster               = var.vc_cluster
  host                  = var.vc_host
  resource_pool         = var.vc_resource_pool
  datastore             = var.vc_datastore

  # Run Configuration
  #boot_order            = "disk,cdrom"

  # Shutdown Configuration
  shutdown_command      = "echo 'vagrant'|sudo -S shutdown -P now"
  shutdown_timeout      = "10m"

  # Wait Configuration

  # ISO Configuration
  iso_paths             = ["${var.vc_centos7iso}", "${var.vc_toolsiso}"]

  guest_os_type         = "centos7_64Guest"
  network_adapters {
    network_card          = "vmxnet3"
    network               = var.vc_network
  }
  notes                 = "Packer template provisioned on ${local.packerStartTime}"
  disk_controller_type  = ["pvscsi"]
  storage {
    disk_size             = "${var.disk_size}"
    disk_thin_provisioned = true
    
  }
  
  # Communicator Configuration
  ssh_username        = "${var.ssh_username}"
  ssh_password        = "${var.ssh_password}"
  ssh_timeout         = "12h"
  
  # Convert to template to yes
  convert_to_template   = true

}

build {
  sources = ["source.vsphere-iso.centos7"]

  #provisioner "powershell" {
  #  elevated_password = "${var.winrm_pass}"
  #  elevated_user     = "${var.winrm_user}"
  #  environment_vars  = ["DO_WIN_UPDATES=${var.do_win_updates}"]
  #  scripts           = ["scripts/windows/windowsupdates.ps1"]
  #}

  #provisioner "windows-restart" {
  #}

  #provisioner "powershell" {
  #  elevated_password = "${var.winrm_pass}"
  #  elevated_user     = "${var.winrm_user}"
  #  environment_vars  = ["DO_WIN_UPDATES=${var.do_win_updates}"]
  #  scripts           = ["scripts/windows/windowsupdates.ps1"]
  #}

  #provisioner "windows-restart" {
  #}

}
