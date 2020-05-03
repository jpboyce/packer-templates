# Install VMware Tools using the ISO that's uploaded to the VM

# Setup variables
$iso_checksum = "8f1cc3181055891b98672f715e0ca7bbe4018960eae945d7a4b9f640c44c3d79"

# Start transcript log
Start-Transcript -Verbose

# Download the file
$isoUrl = "http://$($env:HTTP_IP):$($env:HTTP_PORT)$($env:VMWARE_TOOLS_PATH)"
$localIsoPath = Join-Path -Path $env:TEMP -ChildPath "vmwaretools.iso"
Write-Output "Using ISO URL of: $isoURL"
Write-Output "Saving ISO to: $localIsoPath"

$webClient = New-Object System.Net.WebClient
$timer = Measure-Command -Expression { $webClient.DownloadFile($isoUrl,$localIsoPath) }
Write-Output "Transfer time: $($timer.Milliseconds) milliseconds"

# If the file doesn't exist, just loop for a while
Write-Output "Starting checks for the ISO file..."
while (!(Test-Path $localIsoPath)) {
  Write-Output "ISO file doesn't exist, sleeping..."
  Start-Sleep 10
}

# Check the checksum
Write-Output "ISO File exists, checking the checksum..."
$current_checksum = (Get-FileHash -Path $localIsoPath -Algorithm SHA256).hash.tolower()
Write-Output "Current checksum is: $($current_checksum)"
if ($current_checksum -eq $iso_checksum) {
  Write-Output "The checksum matches what it should be, we can continue!"
  Write-Output "Mounting the ISO as X: drive..."
  Mount-DiskImage -ImagePath $localIsoPath -StorageType ISO -NoDriveLetter -Verbose
  $drive = Get-WmiObject win32_volume -Filter "Label = 'VMware Tools'"
  $drive.DriveLetter = "X:"
  $drive.Put()

  Write-Output "Starting VMware Tools  installation..."
  Start-Process -FilePath "X:\setup.exe" -ArgumentList "/S /v `"/qn REBOOT=R`"" -Wait
  Write-Output "Finished installing!"
} else {
  Write-Output "The checksum value did not match..."
}

# Stop transcript log
Stop-Transcript -Verbose
