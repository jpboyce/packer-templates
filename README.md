# packer-templates
Packer templates I've created for various work and personal use scenarios.  Acknowledgement to [Joe Fitzgerald's templates](https://github.com/joefitzgerald/packer-windows) that got me started on this.

## Platform Versions
Unless otherwise noted, the templates have been tested on the following products and versions:
* Packer v1.5.5
* VMware ESXi 6.7
* VMware Tools 11.0.6
* Oracle Virtualbox 6.0.18

## Usage
Most of these will build just by specifying the template file.  Some have variables/values that may be deemed sensitive or "secrets" and need to be defined either in an external variables file or as part of the command line.  These variables are prefixed with `ext_`.  A sanitised example of such a file is availble at [here](https://github.com/jpboyce/packer-templates/blob/master/example-variables.json).  To run referencing an external variables file:
`packer build -var-file=MyVariablesFile.json buildFile.json`
Alternatively you could specify them as part of the command line using the `-var` option

## Template List

### VMware
| File Name | Platform | OS | Description | Last Verified |
| --------- | ----------- | ----------- | ----------- | ----------- |
| vmware-CentOS-7-base | ESXi | CentOS 7 | VMware Tools 10.3.5 | :heavy_check_mark:08/06/2019  |
| vmware-windows2016-base | ESXi | Windows 2016 | VMware Tools 10.3.5, Windows Updates |   |
| vmware-windows2019-base | ESXi | Windows 2019 | VMware Tools 10.3.5, Windows Updates | :heavy_check_mark:07/06/2019  |

### VirtualBox
| File Name | Platform | OS | Description | Last Verified |
| --------- | ----------- | ----------- | ----------- | ----------- |
| vbox-centOS-7-base | VirtualBox | CentOS 7 | Base OS | 2020-05-05 |
| vbox-centOS-7-updates | VirtualBox | CentOS 7 | Updates installed | |
| vbox-centOS-8-base | VirtualBox | CentOS 8 | Base OS | 2020-05-05 |
| vbox-windows2012r2-base | VirtualBox | Windows 2012 R2 | Base OS | |
| vbox-windows2012r2core-base | VirtualBox | Windows 2012 R2 | Base OS, Core installation | |
| vbox-windows2012r2-updates | VirtualBox | Windows 2012 R2 | Windows Updates installed | |
| vbox-windows2012r2-wu-prereqs | VirtualBox | Windows 2012 R2 | Windows Updates prereqs installed | |
| vbox-windows2012r-base-cis | VirtualBox | Windows 2012 R2 | Base OS and CIS | |
| vbox-windows2019-base | VirtualBox | Windows 2019 | Windows Updates | :heavy_check_mark:26/05/2019  |

### QEMU
| File Name | Platform | OS | Description | Last Verified |
| --------- | ----------- | ----------- | ----------- | ----------- |
| qemu-centOS-7-base | QEMU | CentOS 7 | Base OS | 01/04/2019 |
| qemu-win2016-base-qcow2 | QEMU | Windows 2016 | Base OS | 01/04/2019 |
| qemu-windows2016-base | QEMU | Windows 2016 | Base OS | 01/04/2019 |

## General Notes
I've tried to create these templates in a way that optimises execution time.  Some examples of this include:
* As noted in the Packer documentation, if Packer is run on Windows 10 with admin rights, it will create a symlink to the `iso_url` if it's a local file.  This skips the step of copying it to Packer's cache folder which can be time consuming depending on the characteristics of the storage involved
* Leveraging Packer's HTTP server functionality.  For VirtualBox templates, the default behaviour is to attempt to "upload" the Guest Additions ISO to the VM being built.  For Windows-based VMs, it wil default to using WinRM for this.  Unfortunately, WinRM is incredibly slow for this, taking about 4.5 minutes to transfer the 57MB ISO.  When using the HTTP server approach, the file is transferred in about a second

## VMware Notes
For the VMware-based template to build, the target ESXi host needs to be configured properly.  Specifically, the following command needs to be run:
`esxcli system settings advanced set -o /Net/GuestIPHack -i 1`
For the CentOS template, VNC functionality is required to issue boot commands (which tells CentOS to use a kickstart file, which automates the whole process).  In ESXi 6.7, the firewall has to be disabled for this to happen:
`esxcli network firewall set --enabled false`

## Folder Structure
Below is a brief explaination of the function/purpose of each folder in this repo:
* answer_files - Contains the unattend.xml files used by Windows templates
* boxes - The location where VirtualBox templates export box files to
* drivers - Driver files used by some templates (currently Vmware drivers for Windows boxes)
* iso - Where ISO files are stored
* kickstart - The location for kickstart files used by the CentOS templates
* output - The default output folder for VirtualBox templates
* resources - ?
* scripts - scripting files (bash and PowerShell) used by various templates
* vagrant-templates - Template files for Vagrant