Get-AppxPackage -Name Microsoft.OutlookForWindows* | Remove-AppxPackage
function Uninstall-App{
    $applist=Get-Content -Path "./uninstall_applist.txt"
    foreach($app in $applist){
        try{
            Get-AppxPackage -Name $app | Remove-AppxPackage
            Write-Host "$app Uninstalled"
        }
        catch{
            Write-Warning "Failed to Uninstall App: $($_.Exception.Message)"
        }
    }
    Read-Host -Prompt "Files Deleted Press Enter for Proceeding: "
}
function Install-App{
    $applist= Get-Content -Path "./install_applist.txt"
    foreach($app in $applist){
        try{
            winget install --id $app -e --accept-package-agreements --accept-source-agreements
            Write-Host "$app Installed"
        }
        catch{
            Write-Warning "Failed to Install App: $($_.Exception.Message)"
        }
    }
    Read-Host -Prompt "Files Installed Press Enter for Proceeding: "
}
Uninstall-App
Install-App