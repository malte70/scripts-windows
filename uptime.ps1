# 
# uptime.ps1
# 
# https://www.linetwork.de/powershell-uptime/
# https://www.majorgeeks.com/content/page/system_uptime.html
# 

##########################################
# Does not work on Windows 11
# 
#$LastBootUpTime = Get-WinEvent -ProviderName eventlog | Where-Object {$_.Id -eq 6005} | Select-Object TimeCreated -First 1 
#$TimeNow = Get-Date 
#$Uptime = New-TimeSpan -Start $LastBootUpTime.TimeCreated.Date -End $TimeNow 

# Works on Windows 11
$Uptime = (Get-Date) - (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime

Write-Host -NoNewline "Uptime: "

if ($Uptime.Days -ge 1) {
	Write-Host -NoNewline $Uptime.Days"days,"$Uptime.Hours
	Write-Host -NoNewline ":"
	Write-Host $Uptime.Minutes
} elseif ($Uptime.Hours -ge 1) {
	Write-Host -NoNewline $Uptime.Hours
	Write-Host -NoNewline ":"
	if ($Uptime.Minutes -lt 10) {
		Write-Host -NoNewline "0"
	}
	Write-Host $Uptime.Minutes"hours"
} else {
	Write-Host $Uptime.Minutes"minutes"
}
