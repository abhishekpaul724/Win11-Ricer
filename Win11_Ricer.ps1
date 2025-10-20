#Apply Registry Edits
function Registry-Edit {
    $reg_edits=Get-Content -Path "./registry_edits.json" | ConvertFrom-Json
    foreach ($change in $reg_edits){
        # Ensure the registry key exists
        if (-not (Test-Path $change.Path)) {
            New-Item -Path $change.Path -Force | Out-Null
        }
        else{
            Write-Output "$($change.Path) already exists."
        }
        # Try to get the current value
        try {
            $currentValue = (Get-ItemProperty -Path $change.Path -Name $change.Name -ErrorAction Stop).$($change.Name)
        } catch {
            $currentValue = $null
        }
        # Set the value if it doesn't exist
        $valueToSet = if ($change.Type -eq "DWORD") { [int]$change.Value } else { $change.Value }
        if ($currentValue -ne $valueToSet) {
            New-ItemProperty -Path $change.Path -Name $change.Name -Value $valueToSet -PropertyType $change.Type -Force | Out-Null
            Write-Output "Set '$($change.Name)' to $($valueToSet) in $($change.Path)"
        } else {
            Write-Output "'$($change.Name)' already set to $($valueToSet) - no changes made."
        }
    }
    Read-Host -Prompt "Registry Edits Completed Press Enter for Proceeding"
}
#Uninstall Bloated Apps
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
    Read-Host -Prompt "Apps Deleted Press Enter for Proceeding: "
}
#Install Ricing and Other Apps
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
    Read-Host -Prompt "Apps Installed Press Enter for Proceeding"
}
#Install Infosec Suite Apps
function Install-Infosec-Suite-App{
    $applist= Get-Content -Path "./infosec_suite.txt"
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
