param (
	[Parameter(
		Mandatory=$true,
		HelpMessage="Path to a file or some other Item.",
		ValueFromPipeline=$true
	)]
	[String[]]
	$Path
)



ForEach ($PathItem in $Path) {
	$Item = Get-Item $PathItem
	
	# 
	# File name
	# 
	Write-Host -NoNewline -ForegroundColor Gray  $Item.Parent
	#Write-Host -NoNewline -ForegroundColor Gray  ([IO.Path]::DirectorySeparatorChar)
	if (Test-Path -Path $Item.FullName -PathType Container) {
		# Path is a folder
		Write-Host -NoNewline -ForegroundColor White $Item.BaseName
		Write-Host            -ForegroundColor Gray  ([IO.Path]::DirectorySeparatorChar)
	} else {
		# Regular file
		Write-Host            -ForegroundColor White $Item.Name
	}
	
	# 
	# Mode
	# 
	Write-Host -NoNewline -ForegroundColor Gray  "Mode:       "
	Write-Host            -ForegroundColor White $Item.Mode

	Write-Host -NoNewline -ForegroundColor Gray  "Attributes: "
	Write-Host            -ForegroundColor White $Item.Attributes

	if (Test-Path -Path $Item -PathType Leaf) {
		Write-Host -NoNewline -ForegroundColor Gray  "Size:       "
		if ($Item.Length -lt 2MB) {
			Write-Host            -ForegroundColor White $Item.Length
			
		} elseif ($Item.Length -lt 1MB) {
			$size = "{0:n2}" -f ($Item.Length/1024)
			Write-Host            -ForegroundColor White "${size} KB"
			
			
		} elseif ($Item.Length -lt 1GB) {
			$size = "{0:n2}" -f ($Item.Length/(1024*1024))
			Write-Host            -ForegroundColor White "${size} MB"
			
			
		} else {
			$size = "{0:n2}" -f ($Item.Length/(1024*1024*1024))
			Write-Host            -ForegroundColor White "${size} GB"
			
		}
	}
	
	Write-Host -NoNewline -ForegroundColor Gray  "Last Access:"
	Write-Host            -ForegroundColor White  $Item.LastAccessTime

	if ($Path.Count -gt 1) {
		Write-Host ""
	}
}
