# Install Windows Updates for Packer template VM

# Start Transcript
Start-Transcript -Verbose

# Start Update Scan
# KB4457129
$session = New-Object -ComObject 'Microsoft.Update.Session'
$searcher = $session.CreateUpdateSearcher()
# $searchresult = $searcher.Search("IsInstalled=0 and Type='Software' and IsHidden=0 And AutoSelectOnWebSites=1")
$searchresult = $searcher.Search("IsInstalled=0 and IsHidden=0 And AutoSelectOnWebSites=1")


if ($searchresult.updates.Count -ne 0 ) {
    Write-Output "The number of updates found: " + $searchresult.updates.Count
    try {
        for($i=0; $i -lt $searchresult.updates.Count; $i++) {
            Write-Output $searchresult.updates.item($i).Title
            #Write-Output $searchresult.updates.item($i)Description
        }} catch {
            Write-Output "Could not output title for item #$($i)"
        }
    }

# End Transcript
Stop-Transcript -Verbose
