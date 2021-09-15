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

variable "os_iso_url" {
  type    = string
  default = "[nas01-iso] centos/CentOS-8.1.1911-x86_64-dvd1.iso"
}

variable "tools_iso_url" {
  type    = string
  default = "[nas01-iso] vmware/VMware-tools-windows-11.0.6-15940789.iso"
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

variable "ext_vc_server" {
  type = string
}
variable "ext_vc_username" {
  type = string
}
variable "ext_vc_password" {
  type = string
}
variable "ext_vc_cluster" {
  type = string
}
variable "ext_esxi_host" {
  type = string
}
variable "ext_vc_resource_pool" {
  type = string
}
variable "ext_vc_datastore" {
  type = string
}
variable "ext_vc_network" {
  type = string
}
variable "build_name" {
  type = string
  default = "packer-vsph-centOS8-base"
}

source "vsphere-iso" "centOS8" {
  # HTTP Configuration
  #http_directory        = "${var.http_dir}"
  #http_port_max         = "${var.http_port}"
  #http_port_min         = "${var.http_port}"

  # Connection Configuration
  vcenter_server        = var.ext_vc_server
  username              = var.ext_vc_username
  password              = var.ext_vc_password
  insecure_connection   = "true"

  # Hardware Configuration
  CPUs                  = var.cpu_count
  RAM                   = var.memory_size
  RAM_reserve_all       = false
  firmware              = "bios"

  # Location Configuration
  vm_name               = "${var.build_name}"
  folder                = "Templates"
  cluster               = var.ext_vc_cluster
  host                  = var.ext_esxi_host
  resource_pool         = var.ext_vc_resource_pool
  datastore             = var.ext_vc_datastore

  # Run Configuration
  boot_order            = "disk,cdrom"

  # Shutdown Configuration
  shutdown_command      = "echo 'vagrant'|sudo -S shutdown -P now"
  shutdown_timeout      = "10m"

  # Wait Configuration

  # ISO Configuration
  iso_paths             = ["${var.os_iso_url}", "${var.tools_iso_url}"]

  # Create Configuration
  guest_os_type         = "centos8_64Guest"
  network_adapters {
    network_card          = "vmxnet3"
    network               = var.ext_vc_network
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
  sources = ["source.vsphere-iso.centOS8"]

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
