param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet(
        'LocalDateTime',
        'TimeZoneName',
        'DiskDriveStatus',
        'ProductDump',
        'UninstallProductLike',
        'BackupEventLogs',
        'ClearEventLogs',
        'SetAutomaticManagedPagefile',
        'DriveFreeMb',
        'CreateFileList',
        'GenerateSummaries',
        'WmiCheck'
    )]
    [string]$Action,

    [Parameter(Position = 1)]
    [string]$Value,

    [Parameter(Position = 2)]
    [string]$Path
)

$ErrorActionPreference = 'Stop'

function Get-UninstallEntries {
    $paths = @(
        'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*',
        'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
    )

    if (-not [Environment]::Is64BitOperatingSystem) {
        $paths = @($paths[0])
    }

    Get-ItemProperty -Path $paths -ErrorAction SilentlyContinue |
        Where-Object { $_.DisplayName } |
        Select-Object @{
            Name = 'IdentifyingNumber'
            Expression = {
                if ($_.PSChildName -match '^\{[0-9A-Fa-f-]{36}\}$') { $_.PSChildName } else { '' }
            }
        }, DisplayName, DisplayVersion, UninstallString, QuietUninstallString
}

switch ($Action) {
    'LocalDateTime' {
        $os = Get-CimInstance -ClassName Win32_OperatingSystem
        $dt = $os.LocalDateTime
        $offset = $dt.ToString('zzz').Replace(':', '')
        '{0}{1}' -f $dt.ToString('yyyyMMddHHmmss.ffffff'), $offset
    }

    'TimeZoneName' {
        (Get-CimInstance -ClassName Win32_TimeZone).StandardName
    }

    'DiskDriveStatus' {
        Get-CimInstance -ClassName Win32_DiskDrive | ForEach-Object { $_.Status }
    }

    'ProductDump' {
        'IdentifyingNumber  Name  Version'
        Get-UninstallEntries |
            Sort-Object DisplayName |
            ForEach-Object {
                '{0}  {1}  {2}' -f $_.IdentifyingNumber, $_.DisplayName, $_.DisplayVersion
            }
    }

    'UninstallProductLike' {
        $pattern = if ($Value) { $Value.Replace('%', '*') } else { '*' }
        $matches = Get-UninstallEntries | Where-Object {
            $_.IdentifyingNumber -and $_.DisplayName -like $pattern
        }

        foreach ($entry in $matches) {
            Write-Output ("Uninstalling {0} ({1})" -f $entry.DisplayName, $entry.IdentifyingNumber)
            $p = Start-Process -FilePath 'msiexec.exe' -ArgumentList @('/x', $entry.IdentifyingNumber, '/qn', '/norestart') -Wait -PassThru
            Write-Output ("msiexec exit code: {0}" -f $p.ExitCode)
            if ($p.ExitCode -notin @(0, 1605, 1614, 3010)) {
                exit $p.ExitCode
            }
        }
    }

    'BackupEventLogs' {
        if (-not $Value) {
            throw 'BackupEventLogs requires a destination directory.'
        }

        New-Item -ItemType Directory -Path $Value -Force | Out-Null
        wevtutil.exe el | ForEach-Object {
            $logName = $_
            $safeName = ($logName -replace '[\\/:*?"<>|]', '_')
            $dest = Join-Path $Value "$safeName.evtx"
            Write-Output "Backing up $logName to $dest"
            wevtutil.exe epl "$logName" "$dest" 2>$null
        }
    }

    'ClearEventLogs' {
        wevtutil.exe el | ForEach-Object {
            Write-Output "Clearing $_"
            wevtutil.exe cl "$_" 2>$null
        }
    }

    'SetAutomaticManagedPagefile' {
        $computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem
        Set-CimInstance -InputObject $computerSystem -Property @{ AutomaticManagedPagefile = $true } | Out-Null
        'AutomaticManagedPagefile=True'
    }

    'DriveFreeMb' {
        $drive = if ($Value) { $Value.TrimEnd('\') } else { $env:SystemDrive }
        $deviceId = if ($drive.EndsWith(':')) { $drive } else { "${drive}:" }
        $disk = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='$deviceId'"
        [math]::Floor($disk.FreeSpace / 1MB)
    }

    'CreateFileList' {
        if (-not $Value) {
            throw 'CreateFileList requires an output path.'
        }

        $root = if ($Path) { $Path } else { $env:SystemDrive }
        Get-ChildItem -LiteralPath $root -Recurse -Force -ErrorAction SilentlyContinue |
            Select-Object -ExpandProperty FullName |
            Set-Content -LiteralPath $Value -Encoding ASCII
    }

    'GenerateSummaries' {
        if (-not $Value -or -not $Path) {
            throw 'GenerateSummaries requires raw logs path and summary logs path.'
        }

        New-Item -ItemType Directory -Path $Path -Force | Out-Null

        $beforeFilesPath = Join-Path $Value 'filelist-before.txt'
        $afterFilesPath = Join-Path $Value 'filelist-after.txt'
        $removedFilesPath = Join-Path $Path 'tron_removed_files.txt'
        if ((Test-Path -LiteralPath $beforeFilesPath) -and (Test-Path -LiteralPath $afterFilesPath)) {
            $afterFiles = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
            Get-Content -LiteralPath $afterFilesPath -ErrorAction SilentlyContinue | ForEach-Object { [void]$afterFiles.Add($_) }
            Get-Content -LiteralPath $beforeFilesPath -ErrorAction SilentlyContinue |
                Where-Object {
                    $_ -and
                    -not $afterFiles.Contains($_) -and
                    $_ -notmatch '\$RECYCLE' -and
                    $_ -notmatch 'AppData\\' -and
                    $_ -notmatch 'ntuser\.dat'
                } |
                Set-Content -LiteralPath $removedFilesPath -Encoding ASCII
        } else {
            'File list snapshots were not available.' | Set-Content -LiteralPath $removedFilesPath -Encoding ASCII
        }

        $beforeProgramsPath = Join-Path $Value 'installed-programs-before.txt'
        $afterProgramsPath = Join-Path $Value 'installed-programs-after.txt'
        $removedProgramsPath = Join-Path $Path 'tron_removed_programs.txt'
        if ((Test-Path -LiteralPath $beforeProgramsPath) -and (Test-Path -LiteralPath $afterProgramsPath)) {
            $afterPrograms = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
            Get-Content -LiteralPath $afterProgramsPath -ErrorAction SilentlyContinue |
                Where-Object { $_ -and $_ -ne 'IdentifyingNumber  Name  Version' } |
                ForEach-Object { [void]$afterPrograms.Add($_) }

            $removedPrograms = @(
                Get-Content -LiteralPath $beforeProgramsPath -ErrorAction SilentlyContinue |
                    Where-Object { $_ -and $_ -ne 'IdentifyingNumber  Name  Version' -and -not $afterPrograms.Contains($_) }
            )

            if ($removedPrograms.Count -gt 0) {
                $removedPrograms | Set-Content -LiteralPath $removedProgramsPath -Encoding ASCII
            } else {
                'No programs were removed.' | Set-Content -LiteralPath $removedProgramsPath -Encoding ASCII
            }
        } else {
            'Installed-program snapshots were not available.' | Set-Content -LiteralPath $removedProgramsPath -Encoding ASCII
        }
    }

    'WmiCheck' {
        Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -ExpandProperty Name
    }
}
