$user="tmesa"
$pass="Wetcom01"
$vcenter="192.168.12.60"
Connect -VIServer -Server$vcenter -User$user -Password$pass
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP$false -Confirm:$false

$VMs=Get-VM
$DateToCompare=(Get-Date).AddDays(-365)

$restorePoints=$VMs|ForEach-Object{
    Get-VBRRestorePoint -Name$_.Name|
         Where-Object{$_.CreationTime -gt$DateToCompare}
}|Select-Object VMName,Creation Time

$restorePoints|Group-Object VMName Select-Object Name,Count|Export-Csv.\output.csv'-NoType
