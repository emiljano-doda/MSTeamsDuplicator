# Usage
For some reason Microsoft has disabled the ability to run multiple  work/school profiles on the same Microsoft Teams instance .
What this script does it basically creates a new profile (Named by default : NewProfile) in order to run the same .exe of the teams with another profile.

# Requirements
- Windows
- Microsoft Teams

# Usage
Run the script the script below through PowerShell :
# Script
$ScriptFromGitHub = Invoke-WebRequest https://raw.githubusercontent.com/emiljano-doda/MSTeamsDuplicator/master/MSTeamsDuplicator.ps1
Invoke-Expression $($ScriptFromGitHub.Content)
