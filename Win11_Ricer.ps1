#Apply Registry Edits
function Registry-Edit {
    reg import "$PSScriptRoot\registry_edits.reg"
    Read-Host -Prompt "Registry Edits Completed Press Enter for Proceeding"
}
#Uninstall Bloated Apps
function Uninstall-App{
    $applist=Get-Content -Path "$PSScriptRoot/uninstall_applist.txt"
    foreach($app in $applist){
        try{
            Get-AppxPackage -Name $app | Remove-AppxPackage
            Write-Host "$app Uninstalled"
        }
        catch{
            Write-Warning "Failed to Uninstall App: $($_.Exception.Message)"
        }
    }
    Read-Host -Prompt "Apps Deleted Press Enter for Proceeding: "
}
#Install Ricing and Other Apps
function Install-App{
    $applist= Get-Content -Path "$PSScriptRoot/install_applist.txt"
    foreach($app in $applist){
        try{
            winget install --id $app -e --accept-package-agreements --accept-source-agreements
            Write-Host "$app Installed"
        }
        catch{
            Write-Warning "Failed to Install App: $($_.Exception.Message)"
        }
    }
    Read-Host -Prompt "Apps Installed Press Enter for Proceeding"
}
#Install Infosec Suite Apps
function Install-Infosec-Suite-App{
    $applist= Get-Content -Path "$PSScriptRoot/infosec_suite.txt"
    foreach($app in $applist){
        try{
            winget install --id $app -e --accept-package-agreements --accept-source-agreements
            Write-Host "$app Installed"
        }
        catch{
            Write-Warning "Failed to Install App: $($_.Exception.Message)"
        }
    }
    Read-Host -Prompt "Apps Installed Press Enter for Proceeding"
}
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}
while($true){
    # Menu
    clear
    Write-Host "`nChoose an option:"
    Write-Host "1. Uninstall Apps"
    Write-Host "2. Install Standard Apps"
    Write-Host "3. Install Infosec Suite"
    Write-Host "4. Apply Registry Edits"
    Write-Host "0. Exit"

    $choice = Read-Host -Prompt "Enter your choice (0/1/2/3)"
    switch ($choice) {
        "1" { Uninstall-App }
        "2" { Install-App }
        "3" { Install-Infosec-Suite-App }
        "4" { Registry-Edit }
        "0" { exit }
        default { Write-Warning "Invalid choice. Please try again." }
    }
}
