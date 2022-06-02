$jobs = Get-VBRJob
$data = @()
foreach ($job in $jobs) 
{
  $lastResult = $job.GetLastResult()
  $data += $job | select Name, @{n='Ultimo status';e={$lastResult}}
}

$data | export-csv C:\data.csv 
