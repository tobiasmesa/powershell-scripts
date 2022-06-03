$vcenter = "192.168.12.60"
$user = "tmesa"
$password = "Wetcom01"

Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false -Confirm:$false

Connect-VIServer -Server $vcenter -User $user -Password $password

$datastore = Get-Datastore | Select @{N="DataStoreName";E={$_.Name}},@{N="Percentage Free Space(%)";E={[math]::Round(($_.FreeSpaceGB)/($_.CapacityGB)*100,2)}}
$datastore | Export-Csv -NoTypeInformation $LogFile
