$jobs = Get-VBRJob
$data = @()
foreach ($job in $jobs) 
{
  $lastResult = $job.GetLastResult()
  $data += $job | select @{n='Name'; e={$job.Name}}, @{n='Ultimo status';e={$lastResult}}
}

$data | export-csv C:\data.csv 
