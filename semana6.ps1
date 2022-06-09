Source Code:
#Connect to vCenter
#Connect-VIServer -Server $vc -User $vcuser -Password $vcpass
$Report =@()

#Get the VM
$VMs = Get-view -ViewType VirtualMachine

# Add Filter to retrieve specific VM name
#Get-View -ViewType VirtualMachine -Filter @{“Name” = “do*”}

ForEach ($vm in $VMs)
{
$VMInfo = {} | Select VMName,OSName,VMVersion,IPAddressNIC1,VMToolVersion,VMToolsStatus,Num_CPU,Mem_GB,TotalDisk,DiskCapacity,DiskFree,DiskUsed, Powerstate
$VMInfo.VMName = $vm.name
$VMInfo.Powerstate = $vm.summary.runtime.powerstate
$VMInfo.OSName = $vm.config.GuestFullName
$VMInfo.VMVersion = $vm.config.version
$VMInfo.IPAddressNIC1 = $vm.Guest.IPAddress
$VMInfo.VMToolVersion = $vm.Guest.ToolsVersion
$VMInfo.VMToolsStatus = $vm.Guest.ToolsStatus
$VMInfo.Num_CPU = $vm.config.Hardware.NumCPU
$VMInfo.Mem_GB = ($vm.config.Hardware.MemoryMB)/1024
$VMInfo.TotalDisk = $vm.Guest.Disk.Length
$VMInfo.DiskCapacity = [math]::Round($vm.Guest.Disk.Capacity/1GB)
$VMInfo.DiskFree = [math]::Round($vm.Guest.Disk.FreeSpace/1GB)
$VMInfo.DiskUsed = $VMInfo.DiskCapacity – $VMInfo.DiskFree$Report += $VMInfo
#Information in GUI
$Report | Out-Gridview
#Export to CSV,Uncomment
$Report | export-csv .\test.csv
}

Get-VM | Sort-Object -Property Name | Get-View -Property @("Name", "Config.GuestFullName", "Guest.GuestFullName") |
Select -Property Name, @{N="Configured OS";E={$_.Config.GuestFullName}}, @{N="Running OS";E={$_.Guest.GuestFullName}} | Export-CSV C:\report.csv -NoTypeInformation