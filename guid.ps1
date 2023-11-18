#Set-StrictMode -Version Latest
<#PSScriptInfo

.VERSION 1.0

.GUID 81e9e650-1b64-4e56-89ae-4a58c5c34241

.AUTHOR Malte Bublitz <mail@rolltreppe3.de>, https://malte70.de

.COMPANYNAME rolltreppe3

.COPYRIGHT © 2020 Malte Bublitz

.LICENSEURI https://github.com/malte70/scripts-windows/blob/master/LICENSE

.PROJECTURI https://github.com/malte70/scripts-windows

#>

<# 

.DESCRIPTION 
 Generate GUIDs, optionally without '{}' braces

.EXAMPLE
PS> guid.ps1 -Count 10 -WithBraces $true
Generating 10 GUIDs:
{fc617c50-78b7-4955-a6ca-98a95ac82b97}
{5e8c63ad-096c-4def-aa47-1060ee2ae21c}
{9e123eab-eab0-4a31-8d27-5b05fbbd203c}
{080393e2-8529-46c6-9437-ae3830b5384d}
{5a98ede0-f681-48c2-8e68-af71f50bacc3}
{362c0123-aced-4321-b424-aebf2a0dba15}
{4ea6e6b7-cced-40e9-bb58-328df46a83e1}
{76348318-bf7f-498a-a23c-3e856ca14002}
{d51aaa14-035d-4236-a2c5-0064babbf71e}
{d5bce6a0-0042-4cde-b669-8a0600f0e00a}

.LINK [System.Guid]::NewGuid()
#>

Param(
	# How many GUIDs to generate
	[int]
	[ValidateRange("Positive")]
	[Parameter(Mandatory=$false)]
	$Count = 5,
	
	# Wrap GUID in {} (default: $true)
	[bool]$WithBraces = $true
)

if ($Count -gt 1) {
	Write-Output "Generating $Count GUIDs:"
}

for ($i=0; $i -lt $Count; $i++) {
	$guid = [guid]::NewGuid().Guid
	if ($WithBraces) {
		Write-Output "{$guid}"
	} else {
		Write-Output "$guid"
	}
}
