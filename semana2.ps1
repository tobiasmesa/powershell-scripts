$vcenter = "192.168.12.60"
$user = "tmesa"
$password = "Wetcom01"

Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false -Confirm:$false

Connect-VIServer -Server $vcenter -User $user -Password $password

$todayDate = Get-Date
$snapshots = Get-VM | Get-Snapshot| Where {$_.Created -lt (Get-Date).AddDays(-7)}

$snapshots | Select-Object VM, created 
