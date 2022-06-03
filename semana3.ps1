$vcenter = "192.168.12.60"
$user = "tmesa"
$password = "Wetcom01"

Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false -Confirm:$false


Connect-VIServer -Server $vcenter -User $user -Password $password
$datastore = @()
$datastore = Get-Datastore 
$datastore = Select @{N="Datastore Name";E={$_.Name}},@{N="Free Space(%)";E={[math]::Round(($_.FreeSpaceGB)/($_.CapacityGB)*100,2)}},@{N="Free Space(GB)";E={[math]::Round($_.FreeSpaceGB)}},@{N="Capacity Total(GB)";E={[math]::Round($_.CapacityGB)}}

$datastore | Export-Csv -Path C:\miData.csv 
