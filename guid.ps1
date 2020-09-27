# 
# guid.ps1
#     Generate GUIDs
# 
# Usage:
#     guid.ps1 <Count> [<WithBraces>]
#      - Count: int
#      - WithBraces: bool
# 

param(
	[int]
	$Count = 5,
	
	[bool]
	$WithBraces = 1
)

if ($Count -gt 1) {
	Write-Host "Generating $Count GUIDs:"
}

for ($i=0; $i -lt $Count; $i++) {
	$guid = [guid]::NewGuid().Guid
	if ($WithBraces) {
		Write-Host "{$guid}"
	} else {
		Write-Host "$guid"
	}
}
