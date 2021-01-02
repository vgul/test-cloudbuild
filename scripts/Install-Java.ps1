
#
# https://www.reddit.com/r/PowerShell/comments/83ry2r/installing_java_from_exe_with_flags/dvlq82s/?utm_source=reddit&utm_medium=web2x&context=3
# [string]$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
#

[string]$Timestamp = [DateTime]::UtcNow.ToString('yyyy-MM-dd-HH-mm-ss-fffffff')

[string]$JavaHomePath = "C:\Java-jdk-11.0.9"
[string]$JavaLogName  = ("java-install-{0}.log" -f $Timestamp)
[string]$LogPath      = "${env:UserProfile}"
[string]$JavaLogFile  = Join-Path -Path "$LogPath" -ChildPath "$JavaLogName"

Write-Host "Installing Java [Dir:${JavaHomePath}, Time:${Timestamp}, Log:${JavaLogFile}]"


& ".\Downloads\jdk-11.0.9_windows-x64_bin.exe" `
    "INSTALL_SILENT=Enable" `
    "AUTO_UPDATE=Disable" `
    "EULA=Disable" `
    "WEB_JAVA_SECURITY_LEVEL=VH" `
    "WEB_ANALYTICS=Disable" `
    "WEB_JAVA=Disable" `
    "SPONSORS=Disable" `
    "/L" "$JavaLogFile" `
    "INSTALLDIR=${JavaHomePath}" `
    *>&1 | Out-Default

if ($LastExitCode -ne 0) {
	throw "Java install failed with exit code $LastExitCode"
}
Write-Host "Java installation finished`n`n"

Write-Host "Add '${JavaHomePath}' to PATH"
[string]$OldPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path

[string]$NewPath = "${OldPath};${JavaHomePath}\bin"

Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $NewPath

Write-Host "`nCurrently PATH consists of:"
[string]$CurPath=(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
echo $CurPath.split(";")

Write-Host "`nSet JAVA_HOME to '${JavaHomePath}'"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name JAVA_HOME -Value ${JavaHomePath}
Write-Host "`nJava insallation finished"

