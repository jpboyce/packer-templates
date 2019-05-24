# Allows WinRM functionality used by Packer

# Start transcript
Start-Transcript -Verbose
netsh advfirewall firewall add rule name="WinRM-HTTP" dir=in localport=5985 protocol=TCP action=allow
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
# End Transcript
Stop-Transcript -Verbose
