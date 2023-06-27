# Checks if Microsoft Teams is already installed or not
$FolderName = "$env:LOCALAPPDATA\Microsoft\Teams\"
if([System.IO.Directory]::Exists($FolderName))
{
    # Uses the file name as the profile name
    $MSTEAMS_PROFILE = 'NewProfile'

    Write-Host "Using profile '$MSTEAMS_PROFILE'" -ForegroundColor Green

    # Set the custom profile path
    $USERPROFILE = Join-Path $env:LOCALAPPDATA "Microsoft\Teams\CustomProfiles\$MSTEAMS_PROFILE"

    # Set the old user profile
    $OLD_USERPROFILE = $env:USERPROFILE

    # Launch MS Teams with the custom profile
    Write-Host "Launching another Teams instance with profile named : '$MSTEAMS_PROFILE'" -ForegroundColor Green
    Set-Location "$OLD_USERPROFILE\AppData\Local\Microsoft\Teams"

    $teamsProcessStartInfo = New-Object System.Diagnostics.ProcessStartInfo
    $teamsProcessStartInfo.FileName = "$OLD_USERPROFILE\AppData\Local\Microsoft\Teams\Update.exe"
    $teamsProcessStartInfo.Arguments = "--processStart ""Teams.exe"""
    $teamsProcessStartInfo.WorkingDirectory = "$OLD_USERPROFILE\AppData\Local\Microsoft\Teams"
    $teamsProcessStartInfo.EnvironmentVariables["USERPROFILE"] = $USERPROFILE
    $teamsProcessStartInfo.UseShellExecute = $false

    [System.Diagnostics.Process]::Start($teamsProcessStartInfo) | Out-Null

    # Creates a Desktop folder if it doesn't exists on the CustomProfiles Folder
    # to avoid the error popping up while saving a file from new user profile for the first time
    $FolderName = "$env:LOCALAPPDATA\Microsoft\Teams\CustomProfiles\$MSTEAMS_PROFILE\Desktop"
    if([System.IO.Directory]::Exists($FolderName))
    {
        Write-Host "Folder Already Exists" -ForegroundColor Green
        Get-ChildItem -Path $FolderName | Where-Object {$_.CreationTime -gt (Get-Date).Date}  
    }
    else
    {
        Write-Host "Folder Doesn't Exists , Creating it" -ForegroundColor Green
        New-Item $FolderName -ItemType Directory
    }

    # Set the user profile back to the old user profile
    $env:USERPROFILE = $OLD_USERPROFILE
}
else
{
    Write-Host "Error : It seems Teams isn't installed in the default path : ..\AppData\Microsoft\Teams\" -ForegroundColor Red
    Write-Host "Aborted : Make sure to install Teams !" -ForegroundColor Red
}