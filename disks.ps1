$disks    = Get-CimInstance Win32_LogicalDisk
$disk_num = $disks.Count

$longest_label_length = 5

for ($i = 0; $i -lt $disk_num; $i++) {
	if ($disks[$i].VolumeName.Length -gt $longest_label_length) {
		$longest_label_length = $disks[$i].VolumeName.Length
	}
}

Write-Host ""
Write-Host -NoNewline "Drive  Label"
for ($i=0; $i -lt $longest_label_length - 5; $i++) {
	Write-Host -NoNewline " "
}
Write-Host "    Size    Used    Free    % Used"
Write-Host -NoNewline "-----  -----"
for ($i=0; $i -lt $longest_label_length - 5; $i++) {
	Write-Host -NoNewline " "
}
Write-Host "    ----    ----    ----    ------"


for ($i = 0; $i -lt $disk_num; $i++) {
	# Drive letter
	Write-Host -NoNewline $disks[$i].DeviceID
	Write-Host -NoNewline "   "
	Write-Host -NoNewline "  "

	# Volume name
	Write-Host -NoNewline $disks[$i].VolumeName
	$fill_needed = $longest_label_length - $disks[$i].VolumeName.Length
	for ($j=0; $j -lt $fill_needed; $j++) {
		Write-Host -NoNewline " "
	}
	Write-Host -NoNewline "  "

	# Used (GB)
	#$disk_free    = $disks[$i].FreeSpace -as [float]
	$disk_free    = $disks[$i].FreeSpace
	$disk_size    = $disks[$i].Size
	$disk_used    = $disk_size-$disk_free
	$disk_used_gb = [math]::Round($disk_used/(1024*1024*1024))
	$disk_free_gb = [math]::Round($disk_free/(1024*1024*1024))
	$disk_size_gb = [math]::Round($disk_size/(1024*1024*1024))
	if ($disk_used_gb -ge 100) {
		$disk_used_space = ""
	} elseif ($disk_used_gb -ge 10) {
		$disk_used_space = " "
	} else {
		$disk_used_space = "  "
	}
	if ($disk_free_gb -ge 100) {
		$disk_free_space = ""
	} elseif ($disk_free_gb -ge 10) {
		$disk_free_space = " "
	} else {
		$disk_free_space = "  "
	}
	if ($disk_size_gb -ge 100) {
		$disk_size_space = ""
	} elseif ($disk_size_gb -ge 10) {
		$disk_size_space = " "
	} else {
		$disk_size_space = "  "
	}
	
	Write-Host -NoNewline $disk_size_space
	Write-Host -NoNewline $disk_size_gb,"GB  "
	Write-Host -NoNewline $disk_used_space
	Write-Host -NoNewline $disk_used_gb,"GB  "
	Write-Host -NoNewline $disk_free_space
	Write-Host -NoNewline $disk_free_gb,"GB  "
	Write-Host -NoNewline "  "

	# Used (%)
	#Write-Output "`$disk_size = $disk_size"
	if ($null -ne $disk_size) {
		$disk_used_percent         = (1-$disk_free/$disk_size)*100
	} else {
		$disk_used_percent         = 0.00
	}
	$disk_used_percent_rounded = [math]::Round($disk_used_percent,1)
	if ($disk_used_percent_rounded -lt 10) {
		Write-Host -NoNewline " "
	}
	Write-Host -NoNewline $disk_used_percent_rounded
	Write-Host " %"
}

Write-Host ""
