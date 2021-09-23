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

variable "do_win_updates" {
  type    = string
  default = "yes"
}

variable "floppy_path" {
  type    = string
  default = "[nas01-iso] vmware/pvscsi-Windows8.flp"
}

#variable "http_dir" {
#  type    = string
#  default = "E:/Software"
#}

#variable "http_ip" {
#  type    = string
#  default = "192.168.20.2"
#}

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
variable "esxi_host" {
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
  default = "packer-vsph-windows2019-base"
}

source "vsphere-iso" "win2019base" {
  # HTTP Configuration
  #http_directory        = "${var.http_dir}"
  #http_port_max         = "${var.http_port}"
  #http_port_min         = "${var.http_port}"

  # Floppy Configuration
  floppy_files          = ["answer_files/2019/vcenter/autounattend.xml", 
                            "drivers/vmware/pvscsi/pvscsi.cat", 
                            "drivers/vmware/pvscsi/pvscsi.inf", 
                            "drivers/vmware/pvscsi/pvscsi.sys", 
                            "drivers/vmware/pvscsi/txtsetup.oem", 
                            "scripts/windows/enable-winrm.ps1", 
                            "scripts/windows/set-powercfg.ps1"]

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
  folder                = var.vc_folder
  cluster               = var.vc_cluster
  host                  = var.esxi_host
  resource_pool         = var.vc_resource_pool
  datastore             = var.vc_datastore

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
    network               = var.vc_network
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
  
  # Convert to template to yes
  convert_to_template   = true

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
