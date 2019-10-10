function Install-PoshDocker {
    if (Get-Module -ListAvailable -Name posh-docker) {
        Write-Host "posh-docker found in modules list, skipping installation..."
        Import-PoshDocker
        return
    }
    Install-Module posh-docker
    Import-PoshDocker
}

function Import-PoshDocker {
    if (-not $env:CMDER_ROOT) {
        Write-Host "Script not running in cmder, skipping auto import of posh-docker"
        return
    }

    $cmderUserProfile = "$env:CMDER_ROOT\config\user_profile.ps1"
    $importPoshSshCommand = "Import-Module posh-docker"

    if (Select-String -Path $cmderUserProfile -Pattern $importPoshSshCommand) {
        Write-Host "Auto import of posh-docker already enabled, skipping configuration..."
        return
    }

    Add-Content -Path $cmderUserProfile -Value $importPoshSshCommand
    Import-Module posh-docker
}

$dockerExePath = 'C:\Program Files\Docker\Docker\Resources\bin'

if ($($env:Path).ToLower().Contains($($dockerExePath).ToLower())) {
    Write-Host "Docker found in PATH, skipping installation..."
    Install-PoshDocker
    Exit
}

choco install docker-desktop
Install-PoshDocker
