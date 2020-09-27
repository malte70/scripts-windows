$_ips = Get-NetIPAddress -PrefixOrigin Dhcp,Manual | Sort-Object -Property ifIndex, AddressFamily

for ($i=0; $i -lt $_ips.Count; $i++) {
	$IfName   = (Get-NetIPInterface -InterfaceIndex $_ips[$i].ifIndex).InterfaceAlias[0]
	$IpFamily = $_ips[$i].AddressFamily
	$Ip       = $_ips[$i].IPAddress
	Write-Host "$IfName ($IpFamily)
	$Ip"
}
