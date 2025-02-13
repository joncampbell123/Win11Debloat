#Requires -RunAsAdministrator

param (
    [switch]$Silent,
    [switch]$RunAppConfigurator,
    [switch]$RunDefaults, [switch]$RunWin11Defaults,
    [switch]$RemoveApps, 
    [switch]$RemoveAppsCustom,
    [switch]$RemoveGamingApps,
    [switch]$RemoveCommApps,
    [switch]$RemoveDevApps,
    [switch]$RemoveW11Outlook,
    [switch]$DisableTelemetry,
    [switch]$DisableBingSearches, [switch]$DisableBing,
    [switch]$DisableLockscrTips, [switch]$DisableLockscreenTips,
    [switch]$DisableWindowsSuggestions, [switch]$DisableSuggestions,
    [switch]$ShowHiddenFolders,
    [switch]$ShowKnownFileExt,
    [switch]$HideDupliDrive,
    [switch]$TaskbarAlignLeft,
    [switch]$HideSearchTb, [switch]$ShowSearchIconTb, [switch]$ShowSearchLabelTb, [switch]$ShowSearchBoxTb,
    [switch]$HideTaskview,
    [switch]$DisableCopilot,
    [switch]$DisableWidgets,
    [switch]$HideWidgets,
    [switch]$DisableChat,
    [switch]$HideChat,
    [switch]$ClearStart,
    [switch]$RevertContextMenu,
    [switch]$DisableOnedrive, [switch]$HideOnedrive,
    [switch]$Disable3dObjects, [switch]$Hide3dObjects,
    [switch]$DisableMusic, [switch]$HideMusic,
    [switch]$DisableIncludeInLibrary, [switch]$HideIncludeInLibrary,
    [switch]$DisableGiveAccessTo, [switch]$HideGiveAccessTo,
    [switch]$DisableShare, [switch]$HideShare
)

Clear-Host
Write-Output "-------------------------------------------------------------------------------------------"
Write-Output " Win11Debloat Script - Get"
Write-Output "-------------------------------------------------------------------------------------------"

# Make sure winget is installed and is at least v1.4
if ((Get-AppxPackage -Name "*Microsoft.DesktopAppInstaller*") -and ((winget -v) -replace 'v','' -gt 1.4)) {
    # Install git if it isn't already installed
    Write-Output "> Installing git..."
    winget install git.git --accept-package-agreements --accept-source-agreements --disable-interactivity --no-upgrade

    # Navigate to user temp directory
    cd $env:TEMP 

    # Add default install location of git to path
    $env:Path += ';C:\Program Files\Git\cmd'

    Write-Output ""

    # Download Win11Debloat from github
    Write-Output "> Downloading Win11Debloat..."
    git clone https://github.com/Raphire/Win11Debloat/ 

    # Make list of arguments
    $args = $($PSBoundParameters.GetEnumerator() | ForEach-Object {"-$($_.Key)"})

    Write-Output ""

    # Start & run script with the provided arguments
    Write-Output "> Running Win11Debloat..."
    $debloatProcess = Start-Process powershell.exe -PassThru -ArgumentList "-executionpolicy bypass -File .\Win11Debloat\Win11Debloat.ps1 $args"
    $debloatProcess.WaitForExit()

    Write-Output ""

    # Cleanup, remove Win11Debloat directory
    Write-Output "> Cleaning up..."
    Remove-Item -LiteralPath "Win11Debloat" -Force -Recurse
}
else {
    Write-Error "Unable to start script, Winget is not installed or outdated."
}
