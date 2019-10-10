$chocoExePath = 'C:\ProgramData\Chocolatey\bin'

function Enable-GlobalConfirmation {
    choco feature enable -n allowGlobalConfirmation
}

if ($($env:Path).ToLower().Contains($($chocoExePath).ToLower())) {
    Write-Host "Chocolatey found in PATH, running upgrade..."
    Enable-GlobalConfirmation
    choco upgrade chocolatey
}

Write-Host "Chocolatey not found in PATH, running installer..."
# Add to system PATH
$systemPath = [Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::Machine)
$systemPath += ';' + $chocoExePath
[Environment]::SetEnvironmentVariable("PATH", $systemPath, [System.EnvironmentVariableTarget]::Machine)

# Update local process' path
$userPath = [Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::User)
if ($userPath) {
    $env:Path = $systemPath + ";" + $userPath
}
else {
    $env:Path = $systemPath
}

Invoke-Expression ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
Enable-GlobalConfirmation
