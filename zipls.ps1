param(
	[Parameter(Mandatory)]
	[Alias("Path")]
	[string]
	$ZIPFile,

	[Parameter(Mandatory=$false)]
	[string]
	$OnlyMatching
)

Add-Type -AssemblyName "System.IO.Compression.Filesystem"

$ZIPFile = Get-Item $ZIPFile

$zip = [io.compression.zipfile]::OpenRead($ZIPFile)
for ($i = 0; $i -lt $zip.Entries.Count; $i++) {
	$entry = $zip.Entries[$i]

	if ($OnlyMatching.Length -gt 1) {
		if ($entry.FullName -notmatch $OnlyMatching) {
			continue
		}
	}
	if ($entry.Length -gt 0) {
		$compression_ratio = [System.Math]::Round(($entry.CompressedLength/$entry.Length)*100)
	} else {
		$compression_ratio = -1
	}
	#$size = [System.Math]::Round($entry.Length/1024)
	$size = [System.Math]::Ceiling($entry.Length/4096)*4
	
	if ($compression_ratio -lt 0) {
		Write-Output $entry.FullName
	} else {
		Write-Output "$($entry.FullName) ($size kB, $compression_ratio %)"
	}
}
