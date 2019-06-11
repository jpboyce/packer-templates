# Download and install the Servicing Update for Windows 2016

# Start transcript log
Start-Transcript -Verbose

# Download the file
$fileUrl = "http://$($env:HTTP_IP):$($env:HTTP_PORT)/Microsoft/Windows-2016/kb4498947/windows10.0-kb4498947-x64_97b6d1b006cd564854f39739d4fc23e3a72373d7.msu"
$localFilePath = Join-Path -Path $env:TEMP -ChildPath "windows10.0-kb4498947-x64_97b6d1b006cd564854f39739d4fc23e3a72373d7.msu"
Write-Output "Using file URL of: $fileUrl"
Write-Output "Saving file to: $localFilePath"

$webClient = New-Object System.Net.WebClient
$timer = Measure-Command -Expression { $webClient.DownloadFile($fileUrl,$localFilePath) }
Write-Output "Transfer time: $($timer.Milliseconds) milliseconds"

# If the file doesn't exist, just loop for a while
Write-Output "Starting checks for the file..."
while (!(Test-Path $localFilePath)) {
  Write-Output "file doesn't exist, sleeping..."
  Start-Sleep 10
}

# Run update
$argsList = "$localFilePath /quiet /norestart"
Start-Process "wusa.exe" -ArgumentList $argsList -Wait

# Stop transcript log
Stop-Transcript -Verbose
