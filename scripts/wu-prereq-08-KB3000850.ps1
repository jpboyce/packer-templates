# Installing Windows Updates Prereqs
Start-Transcript -Verbose
$wusa = "$env:systemroot\System32\wusa.exe"
$update = "x:\Windows8.1-KB3000850-x64.msu"
$scriptname = $MyInvocation.MyCommand

# Starting...
Write-Output "[$($scriptname)] Starting execution..."

Write-Output "[$($scriptname)] Checking if patch file is accessable..."
if ((Test-Path $update)) {
  Write-Output "[$($scriptname)] Patch file ($($update)) can be accessed"
} else {
  Write-Output "[$($scriptname)] Patch file ($($update)) can not be accessed, attempting to map drive"
  NET USE X: \\Vboxsvr\2012r2patches
}

Write-Output "[$($scriptname)] Running patch command"
# Start-Process -FilePath $wusa -ArgumentList ($update, '/quiet', '/log') -Verbose -Wait
$patchrun = Start-Process -FilePath $wusa -ArgumentList ($update, '/quiet', '/log') -Verbose -PassThru

for($i = 0; $i -le 100; $i = ($i + 1) % 100) {
  Write-Progress -Activity "Installing $($update)" -PercentComplete $i -Status "Installing..."
  start-sleep -Milliseconds 1000
  if ($patchrun.HasExited) {
    Write-Progress -Activity "Installing $($update)" -Completed
    break
  }
}

Write-Output "[$($scriptname)] Finished execution"

Stop-Transcript -Verbose
