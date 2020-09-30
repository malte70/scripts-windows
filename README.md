# Windows Scripts

## guid.ps1

> Generate GUIDs

Usage:

	guid.ps1 <Count> <WithBraces>

- Count: Integer, defaults to 5
- WithBraces: Bool, defaults to 1 (true)

Example output:

	Generating 5 GUIDs:
	{c406fb59-e791-42c3-862a-2095c029234a}
	{77da83e8-a80e-41aa-9745-22a2843d1a93}
	{523d30c9-ced4-47fb-ac5e-c020de8f6659}
	{97944fa1-f4bd-40c2-93a5-f478687e042a}
	{52a62ba1-2025-41e7-90e6-e77b53596e1a}

## myip.ps1

> Show IPs for all interfaces

Usage:

	myip.ps1

Example output:

	Ethernet (IPv4)
		192.168.0.100
	Ethernet (IPv6)
		acab:1337::42
	vEthernet (Default Switch) (IPv4)
		172.17.208.1

## uptime.ps1

> Show uptime

Usage:

	uptime.ps1

Example output:

	3 days, 14:48
