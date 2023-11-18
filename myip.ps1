param(
	[ValidateSet("All","IPv4","IPv6")]
	[string]
	$AddressFamily = "All",

	[Parameter(Mandatory=$false)]
	[bool]
	$ShowExternal = $false
)

$IPInfoUserAgent = "myip.ps1 (https://github.com/malte70/scripts)"
#$IPInfoURL = "https://ip.malte70.de/api.php"
$IPInfo4URL = "https://ip4.malte70.de/api.php"
$IPInfo6URL = "https://ip6.malte70.de/api.php"

if ($ShowExternal) {
	#Write-Error -Message "Not implemented yet!"
	$r = Invoke-WebRequest -UserAgent $IPInfoUserAgent -Uri $IPInfo4URL
	if ($r.StatusCode -eq 200) {
		$ipv4 = $r.Content
	} else {
		$ipv4 = $false
	}
	$r = Invoke-WebRequest -UserAgent $IPInfoUserAgent -Uri $IPInfo6URL
	if ($r.StatusCode -eq 200) {
		$ipv6 = $r.Content
	} else {
		$ipv6 = $false
	}

	if ($AddressFamily -eq "All" -or $AddressFamily -eq "IPv4") {
		Write-Host "IPv4"
		if ($ipv4 -ne $false) {
			Write-Host "	$ipv4"
		} else {
			Write-Host -ForegroundColor Red "	None"
		}
	}
	if ($AddressFamily -eq "All" -or $AddressFamily -eq "IPv6") {
		Write-Host "IPv6"
		if ($ipv6 -ne $false) {
			Write-Host "	$ipv6"
		} else {
			Write-Host -ForegroundColor Red "	None"
		}
	}

} else {
	$_ips = Get-NetIPAddress -PrefixOrigin Dhcp,Manual | Sort-Object -Property ifIndex, AddressFamily

	for ($i=0; $i -lt $_ips.Count; $i++) {
		if ($AddressFamily -eq "All" -or $AddressFamily -eq $_ips[$i].AddressFamily) {
			$IfName   = (Get-NetIPInterface -InterfaceIndex $_ips[$i].ifIndex).InterfaceAlias[0]
			$IpFamily = $_ips[$i].AddressFamily
			$Ip       = $_ips[$i].IPAddress
			if ($AddressFamily -eq "All") {
				Write-Host "$IfName ($IpFamily)"
			} else {
				Write-Host "$IfName"
			}
			Write-Host "	$Ip"
		}
	}
}
