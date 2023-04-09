$csvPath = Join-Path $PSScriptRoot 'example.csv'
$jsonPath = Join-Path $PSScriptRoot 'example.json'
$outputPath = Join-Path $PSScriptRoot 'new_example.json'

$csv = Import-Csv -Path $csvPath
$json = Get-Content -Path $jsonPath -Raw | ConvertFrom-Json

$newJson = foreach ($record in $csv) {
  $newRecord = $json | Select-Object * 
  $newRecord.name = $record.Name
  $newRecord.age = $record.Age
  $newRecord.email = $record.Email
  $newRecord.address.street = $record.Street
  $newRecord.address.city = $record.City
  $newRecord.address.state = $record.State
  $newRecord.address.zip = $record.Zip
  [PSCustomObject]$newRecord
}

$newJson | ConvertTo-Json -Depth 100 | Out-File -FilePath $outputPath
