# 
# uptime.ps1
# 
# https://www.linetwork.de/powershell-uptime/
# 

$LastBootUpTime = Get-WinEvent -ProviderName eventlog | Where-Object {$_.Id -eq 6005} | Select-Object TimeCreated -First 1 

$TimeNow = Get-Date 

$Uptime = New-TimeSpan -Start $LastBootUpTime.TimeCreated.Date -End $TimeNow 

if ($Uptime.Days -ge 1) {
	Write-Host -NoNewline $Uptime.Days"days,"$Uptime.Hours
	Write-Host -NoNewline ":"
	Write-Host $Uptime.Minutes
} elseif ($Uptime.Hours -ge 1) {
	Write-Host -NoNewline $Uptime.Hours
	Write-Host -NoNewline ":"
	Write-Host $Uptime.Minutes"Hours"
} else {
	Write-Host $Uptime.Minutes"minutes"
}
