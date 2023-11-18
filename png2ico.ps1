param(
	[Parameter(Mandatory)]
	[string]
	$PNGFile
)

$ICOFile = $PNGFile.Substring(0, $PNGFile.LastIndexOf(".")) + ".ico"

convert.exe $PNGFile -define icon:auto-resize="256,128,96,64,48,32,16" $ICOFile
