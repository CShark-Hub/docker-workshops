function Install-VSCodeExtensions {
    $currentExtensionsList = & code --list-extensions

    $extensionsList = @(
        "EditorConfig.EditorConfig",
        "ms-azuretools.vscode-docker"
    )

    foreach ($extensionName in $extensionsList) {
        if ($currentExtensionsList -and $currentExtensionsList.ToLower().Contains($($extensionName).ToLower())) {
            Write-Host "$extensionName already found in vscode extensions list, skipping installation..."
        }
        else {
            & code --install-extension $extensionName
        }
    }
}

$vsCodeExePath = 'C:\Program Files\Microsoft VS Code\bin'

if ($($env:Path).ToLower().Contains($($vsCodeExePath).ToLower())) {
    Write-Host "VSCode found in PATH, skipping installation..."
    Install-VSCodeExtensions
    Exit
}

Write-Host "VSCode not found in PATH, running installer..."
# Add to system PATH
$systemPath = [Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::Machine)
$systemPath += ';' + $vsCodeExePath
[Environment]::SetEnvironmentVariable("PATH", $systemPath, [System.EnvironmentVariableTarget]::Machine)

# Update local process' path
$userPath = [Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::User)
if ($userPath) {
    $env:Path = $systemPath + ";" + $userPath
}
else {
    $env:Path = $systemPath
}

choco install vscode
Install-VSCodeExtensions
