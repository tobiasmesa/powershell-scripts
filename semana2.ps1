Connect-VIServer -Server $vcenter -User $user -Password $password


$snapshots = Get-VM | Get-Snapshot| Where {$_.Created -lt (Get-Date).AddDays(-7)} | Select-Object VM, created | Export-Csv -Path C:\miData.csv

$snapshots | Select-Object VM, created 
Import-Csv -Path C:\miData.csv