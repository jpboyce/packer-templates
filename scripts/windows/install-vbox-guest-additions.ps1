# Install the VirtualBox Guest Additions using the ISO that's uploaded to the test

# Setup variables
# $iso_path = "C:/users/vagrant/vBoxGuestAdditions.iso"
# $iso_checksum = "1a56b8771c5a865f10b44b8d3b821e8404ea2f10978675e5cdc405525de7b5eb"
# Updated checksum
# $iso_checksum = "e51e33500a265b5c2d7bb2d03d32208df880523dfcb1e2dde2c78a0e0daa0603"
$iso_checksum = "10a6683db0ee4c48587b1385a8b90968b1a1a524a739e49baf14b9244327dde7"

# Start transcript log
Start-Transcript -Verbose

# Download the file
$isoUrl = "http://$($env:HTTP_IP):$($env:HTTP_PORT)$($env:URL_PATH)"
$localIsoPath = Join-Path -Path $env:TEMP -ChildPath "VBoxGuestAdditions.iso"
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
  $drive = Get-WmiObject win32_volume -Filter "Label = 'VBox_GAs_6.0.18'"
  $drive.DriveLetter = "X:"
  $drive.Put()

  Write-Output "Installing certificates..."
  Get-ChildItem X:\cert -Filter *.cer | ForEach-Object { certutil -addstore -f "TrustedPublisher" $_.FullName }
  Write-Debug "Finished adding certificates!"

  Write-Output "Starting VBox additions installation..."
  Start-Process -FilePath "X:\VBoxWindowsAdditions.exe" -ArgumentList "/S" -Wait
  Write-Output "Finished installing!"
} else {
  Write-Output "The checksum value did not match..."
}

# Stop transcript log
Stop-Transcript -Verbose
