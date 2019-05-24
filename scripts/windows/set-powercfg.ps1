# Set Power Configuration to High performance and other settings appropriate for VMs

Write-Output "Setting Power Plan to High Performance"
powercfg.exe /SETACTIVE 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

Write-Output "Turning off hybernation..."
powercfg.exe /HIBERNATE OFF
