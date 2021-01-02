
#Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH #).path
#Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name M2_HOME #).path
#exit

[string]$MavenPackageName="apache-maven-3.6.3" # -bin.zip
[string]$MavenPackageHome="C:\${MavenPackageName}"

Expand-Archive -Path ".\Downloads\${MavenPackageName}-bin.zip" `
               -DestinationPath C:\ `
               -Force


Write-Host "`nAdd '${MavenPackageHome}\bin' to PATH"
[string]$OldPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
[string]$NewPath = "${OldPath};${MavenPackageHome}\bin"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $NewPath
Write-Host "`nCurrently PATH consists of:"
[string]$CurPath=(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
echo $CurPath.split(";")



Write-Host "`nSet M2_HOME to '${MavenPackageHome}'"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name M2_HOME -Value "${MavenPackageHome}"

