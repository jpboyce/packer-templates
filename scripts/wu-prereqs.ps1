# Installing Windows Updates Prereqs
Start-Transcript -Verbose
$wusa = "$env:systemroot\System32\wusa.exe"
# Mapping X Drive
NET USE X: \\Vboxsvr\2012r2patches

$update = "x:\Windows8.1-KB2919442-x64.msu"
Start-Process -FilePath $wusa -ArgumentList ($update, '/quiet', '/log') -Verbose
Start-Sleep -Seconds 10

$update = "x:\Windows8.1-KB2919355-x64.msu"
Start-Process -FilePath $wusa -ArgumentList ($update, '/quiet', '/log') -Verbose
Start-Sleep -Seconds 10

$update = "x:\Windows8.1-KB2932046-x64.msu"
Start-Process -FilePath $wusa -ArgumentList ($update, '/quiet', '/log') -Verbose
Start-Sleep -Seconds 10

$update = "x:\Windows8.1-KB2959977-x64.msu"
Start-Process -FilePath $wusa -ArgumentList ($update, '/quiet', '/log') -Verbose
Start-Sleep -Seconds 10

$update = "x:\Windows8.1-KB2937592-x64.msu"
Start-Process -FilePath $wusa -ArgumentList ($update, '/quiet', '/log') -Verbose
Start-Sleep -Seconds 10

$update = "x:\Windows8.1-KB2938439-x64.msu"
Start-Process -FilePath $wusa -ArgumentList ($update, '/quiet', '/log') -Verbose
Start-Sleep -Seconds 10

$update = "x:\Windows8.1-KB2934018-x64.msu"
Start-Process -FilePath $wusa -ArgumentList ($update, '/quiet', '/log') -Verbose
Start-Sleep -Seconds 10

$update = "x:\Windows8.1-KB3000850-x64.msu"
Start-Process -FilePath $wusa -ArgumentList ($update, '/quiet', '/log') -Verbose
Start-Sleep -Seconds 10

$update = "x:\Windows8.1-KB3003057-x64.msu"
Start-Process -FilePath $wusa -ArgumentList ($update, '/quiet', '/log') -Verbose
Start-Sleep -Seconds 10

$update = "x:\Windows8.1-KB3016437-x64.msu"
Start-Process -FilePath $wusa -ArgumentList ($update, '/quiet', '/log') -Verbose
Start-Sleep -Seconds 10

$update = "x:\Windows8.1-KB3014442-x64.msu"
Start-Process -FilePath $wusa -ArgumentList ($update, '/quiet', '/log') -Verbose
Start-Sleep -Seconds 10

Stop-Transcript -Verbose
