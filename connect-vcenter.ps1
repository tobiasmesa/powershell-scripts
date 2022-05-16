$user = "tmesa"
$pass = "Wetcom01"
$vcenter = "192.168.12.60"

Connect-VIServer -Server $vcenter -User $user -Password $pass
