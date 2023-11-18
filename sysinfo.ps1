$adminPasswordStatus = $null
$thermalState        = $null
$osInfo              = Get-CimInstance Win32_OperatingSystem
$computerInfo        = Get-CimInstance Win32_ComputerSystem
$diskInfo            = Get-CimInstance Win32_LogicalDisk

try {
    [System.DirectoryServices.ActiveDirectory.Domain]::GetComputerDomain()
    $domainJoined = 1
} catch {
    $domainJoined = 0
}

Switch ($computerInfo.AdminPasswordStatus) {
    0 {
        $adminPasswordStatus = 'Disabled'
    }
    1 {
        $adminPasswordStatus = 'Enabled'
    }
    2 {
        $adminPasswordStatus = 'Not Implemented'
    }
    3 {
        $adminPasswordStatus = 'Unknown'
    }
    Default {
        $adminPasswordStatus = 'Unable to determine'
    }
}

Switch ($computerInfo.ThermalState) {
    1 {
        $thermalState = 'Other'
    }
    2 {
        $thermalState = 'Unknown'
    }
    3 {
        $thermalState = 'Safe'
    }
    4 {
        $thermalState = 'Warning'
    }
    5 {
        $thermalState = 'Critical'
    }
    6 {
        $thermalState = 'Non-recoverable'
    }
    Default {
        $thermalState = 'Unable to determine'
    }
}

$sysinfoObject = New-Object -TypeName psobject 

$sysinfoObject | Add-Member -MemberType NoteProperty -Name OS                  -Value $osInfo.Caption
$sysinfoObject | Add-Member -MemberType NoteProperty -Name 'OSVersion'        -Value $("$($osInfo.Version) Build $($osInfo.BuildNumber)")
$sysinfoObject | Add-Member -MemberType NoteProperty -Name ComputerName        -Value $computerInfo.Name
if ($domainJoined -eq 1) {
    $sysinfoObject | Add-Member -MemberType NoteProperty -Name Domain          -Value $computerInfo.Domain
    #$sysinfoObject | Add-Member -MemberType NoteProperty -Name Workgroup       -Value $null
} else {
    #$sysinfoObject | Add-Member -MemberType NoteProperty -Name Domain          -Value $null
    $sysinfoObject | Add-Member -MemberType NoteProperty -Name Workgroup       -Value $computerInfo.Workgroup
}
$sysinfoObject | Add-Member -MemberType NoteProperty -Name AdminPasswordStatus -Value $adminPasswordStatus
$sysinfoObject | Add-Member -MemberType NoteProperty -Name ThermalState        -Value $thermalState

$hwInfoObject = New-Object -TypeName psobject
$cimModel = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -Property Manufacturer,Model
$hwInfoObject | Add-Member -MemberType NoteProperty -Name Model -Value $cimModel
$cimCPU = Get-CimInstance -ClassName Win32_Processor | Select-Object -Property Name,NumberOfCores,MaxClockSpeed
$hwInfoObject | Add-Member -MemberType NoteProperty -Name CPU -Value $cimCPU.Name
$cimGPU = Get-CimInstance -ClassName Win32_VideoController | Select-Object -Property Description
$hwInfoObject | Add-Member -MemberType NoteProperty -Name GPU -Value $cimGPU

$sysinfoObject | Add-Member -MemberType NoteProperty -Name Owner               -Value (Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -Property RegisteredUser,Organization)
$sysinfoObject | Add-Member -MemberType NoteProperty -Name Hardware            -Value $hwInfoObject
$sysinfoObject | Add-Member -MemberType NoteProperty -Name Disks               -Value $diskInfo

return $sysinfoObject
