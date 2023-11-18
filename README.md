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

## disks.ps1

> List disk drives along with their size and used capacity

Usage:

	disks.ps1

Example output:

	Drive  Label           Size    Used    Free    % Used
	-----  -----           ----    ----    ----    ------
	C:     Windows       925 GB  666 GB  259 GB    72,3 %
	D:     Data            8 TB  2,4 TB  5,6 TB    30,2 %

## fileinfo.ps1

> Show some information about a file

Usage:

	fileinfo.ps1 <Filename>

Example output:

	README.md
	Mode:       -a---
	Attributes: Archive
	Size:       1123
	Last Access:2021-12-30 16:55:24

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

## png2ico.ps1

> Convert a PNG file into a multi-size ICO file. I just can't remember the
> needed arguments for ImageMagick's convert. *Note: PNG file should be at
> least 256px × 256px.

Usage:

	png2ico.ps1 <MyIcon.png>

## sysinfo.ps1

> Return basic system information as an object

Usage:

	sysinfo.ps1
	(sysinfo.ps1).Owner.RegisteredUser

## uptime.ps1

> Show uptime

Usage:

	uptime.ps1

Example output:

	3 days, 14:48

## zipls.ps1

> List contents of a ZIP archive

Usage:

	zipls.ps1 <Archive.zip>

Example output:

	disks.ps1 (4 kB, 25 %)
	fileinfo.ps1 (4 kB, 29 %)
	guid.ps1 (4 kB, 62 %)
	issue.ps1 (4 kB, 31 %)
	LICENSE (4 kB, 52 %)
	myip.ps1 (4 kB, 37 %)
	png2ico.ps1 (4 kB, 77 %)
	README.md (4 kB, 54 %)
	sysinfo.ps1 (4 kB, 25 %)
	uptime.ps1 (4 kB, 44 %)
	zipls.ps1 (4 kB, 47 %)
