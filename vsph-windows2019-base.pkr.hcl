locals {
  packerStartTime = formatdate("YYYYMMDD-hhmm", timestamp())
}

variable "cpu_count" {
  type    = string
  default = "2"
}

variable "disk_size" {
  type    = string
  default = "51200"
}

variable "do_win_updates" {
  type    = string
  default = "yes"
}

variable "floppy_path" {
  type    = string
  default = "[nas01-iso] vmware/pvscsi-Windows8.flp"
}

variable "http_dir" {
  type    = string
  default = "E:/Software"
}

variable "http_ip" {
  type    = string
  default = "192.168.20.2"
}

variable "http_port" {
  type    = string
  default = "8000"
}

variable "memory_size" {
  type    = string
  default = "8192"
}

variable "os_iso_url" {
  type    = string
  default = "[nas01-iso] microsoft/en_windows_server_2019_updated_oct_2020_x64_dvd_7484fc77.iso"
}

variable "tools_iso_url" {
  type    = string
  default = "[nas01-iso] vmware/VMware-tools-windows-11.0.6-15940789.iso"
}

variable "vm_notes" {
  type    = string
  default = "Packer template provisioned on DATE"
}

variable "winrm_pass" {
  type    = string
  default = "vagrant"
}

variable "winrm_user" {
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


source "vsphere-iso" "win2019base" {
  # HTTP Configuration
  http_directory        = "${var.http_dir}"
  http_port_max         = "${var.http_port}"
  http_port_min         = "${var.http_port}"

  # Floppy Configuration
  floppy_files          = ["answer_files/2019/vcenter/autounattend.xml", "drivers/vmware/pvscsi/Win8/*.*", "drivers/vmware/vmxnet3/Win8/*.*", "drivers/vmware/mouse/Win8/*.*", "scripts/windows/enable-winrm.ps1", "scripts/windows/set-powercfg.ps1"]

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
  vm_name               = "windows2019-base-${local.packerStartTime}"
  folder                = "Templates"
  cluster               = var.ext_vc_cluster
  host                  = var.ext_esxi_host
  resource_pool         = var.ext_vc_resource_pool
  datastore             = var.ext_vc_datastore

  # Run Configuration
  boot_order            = "disk,cdrom"

  # Shutdown Configuration
  shutdown_command      = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout      = "10m"

  # Wait Configuration

  # ISO Configuration
  iso_paths             = ["${var.os_iso_url}", "${var.tools_iso_url}"]

  # Create Configuration
  guest_os_type         = "windows9Server64Guest"
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
  communicator          = "winrm"
  winrm_username        = "${var.winrm_user}"
  winrm_password        = "${var.winrm_pass}"
  winrm_timeout         = "12h"
  

}

build {
  sources = ["source.vsphere-iso.win2019base"]

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
