# packer-templates
Packer templates I've created for my use

## Template List

| File Name | Platform | OS | Description | Last Verified |
| --------- | ----------- | ----------- | ----------- | ----------- |
| qemu-centOS-7-base | QEMU | CentOS 7 | Base OS | |
| qemu-win2016-base-qcow2 | QEMU | Windows 2016 | Base OS | |
| qemu-windows2016-base | QEMU | Windows 2016 | Base OS | |
| vbox-centOS-7-base | VirtualBox | CentOS 7 | Base OS | |
| vbox-centOS-7-updates | VirtualBox | CentOS 7 | Updates installed | |
| vbox-windows2012r2-base | VirtualBox | Windows 2012 R2 | Base OS | |
| vbox-windows2012r2core-base | VirtualBox | Windows 2012 R2 | Base OS, Core installation | |
| vbox-windows2012r2-updates | VirtualBox | Windows 2012 R2 | Windows Updates installed | |
| vbox-windows2012r2-wu-prereqs | VirtualBox | Windows 2012 R2 | Windows Updates prereqs installed | |
| vbox-windows2012r-base-cis | VirtualBox | Windows 2012 R2 | Base OS and CIS | |
| vbox-windows2019-base | VirtualBox | Windows 2019 | Guest Additions 5.2.30, Windows Updates | :white_check_mark: 26/05/2019 :heavy_check_mark: |

## General Notes
I've tried to create these templates in a way that optimises execution time.  Some examples of this include:
* As noted in the Packer documentation, if Packer is run on Windows 10 with admin rights, it will create a symlink to the `iso_url` if it's a local file.  This skips the step of copying it to Packer's cache folder which can be time consuming depending on the characteristics of the storage involved
* Leveraging Packer's HTTP server functionality.  For VirtualBox templates, the default behaviour is to attempt to "upload" the Guest Additions ISO to the VM being built.  For Windows-based VMs, it wil default to using WinRM for this.  Unfortunately, WinRM is incredibly slow for this, taking about 4.5 minutes to transfer the 57MB ISO.  When using the HTTP server approach, the file is transferred in about a second
