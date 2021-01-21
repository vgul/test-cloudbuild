# 
# 5. System configuration
# 
# 5.1. Run powershell as admin
# 5.2. Turn off windows firewall
      netsh advfirewall set allprofiles state off
# 5.3. Disable automatic disk defragmentation
#     PS > Disable-ScheduledTask -TaskName 'ScheduledDefrag' -TaskPath '\Microsoft\Windows\Defrag'
# 5.4. Disable automatic updates (for Win2012 server, other Windows versions may require different commands - https://stackoverflow.com/a/49790849) The commands may display execution errors if WindowsUpdate folder or UpdateOrchestrator folder does not exist
      $WindowsUpdatePath = "HKLM:SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\"
      $AutoUpdatePath = "HKLM:SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
      If(Test-Path -Path $WindowsUpdatePath) { Remove-Item -Path $WindowsUpdatePath -Recurse }
      New-Item $WindowsUpdatePath -Force
      New-Item $AutoUpdatePath -Force
      Set-ItemProperty -Path $AutoUpdatePath -Name NoAutoUpdate -Value 1
      Get-ScheduledTask -TaskPath "\Microsoft\Windows\WindowsUpdate\" | Disable-ScheduledTask
      takeown /F C:\Windows\System32\Tasks\Microsoft\Windows\UpdateOrchestrator /A /R
      icacls C:\Windows\System32\Tasks\Microsoft\Windows\UpdateOrchestrator /grant Administrators:F /T
      Get-ScheduledTask -TaskPath "\Microsoft\Windows\UpdateOrchestrator\" | Disable-ScheduledTask
      Stop-Service wuauserv
      Set-Service wuauserv -StartupType Disabled
      Get-ScheduledTask -TaskPath "\Microsoft\Windows\WindowsUpdate\" | Disable-ScheduledTask
# 5.5. Disable Windows Smart Screen
      Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\System -Name EnableSmartScreen -Value 0 -Force    
# 5.6. Disable Windows Defender (https://serverfault.com/a/880586) (no need on Win2012)
      Remove-WindowsFeature "Windows-Defender-Features"
# 5.7. Disable UAC ( https://support.gfi.com/hc/en-us/articles/360012968753-Disabling-the-User-Account-Control-UAC- https://gallery.technet.microsoft.com/scriptcenter/Disable-UAC-using-730b6ecd )
      New-ItemProperty -Path HKLM:Software\Microsoft\Windows\CurrentVersion\policies\system -Name EnableLUA -PropertyType DWord -Value 0 -Force    
# 5.8. Disable NTFS last access time stamp updates ( https://www.tenforums.com/tutorials/139015-enable-disable-ntfs-last-access-time-stamp-updates-windows-10-a.html )
      fsutil behavior set disablelastaccess 1
# 5.9. Disable DOS 8.3 file names
      fsutil behavior set disable8dot3 1
# 5.10. Remove password complexity requirements (required for local user 'qa')
      secedit /export /cfg c:\secpol.cfg
      (gc C:\secpol.cfg).replace("PasswordComplexity = 1", "PasswordComplexity = 0") | Out-File C:\secpol.cfg
      (gc C:\secpol.cfg).replace("MinimumPasswordLength = 8", "MinimumPasswordLength = 1") | Out-File C:\secpol.cfg
      secedit /configure /db c:\windows\security\local.sdb /cfg c:\secpol.cfg /areas SECURITYPOLICY
      rm -force c:\secpol.cfg -confirm:$false
# 5.11. Disable shutdown tracker ( https://serverfault.com/questions/560505/suppressing-the-reason-for-shutdown-on-windows-server/ )
      New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT' -Name Reliability -Force
      Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Reliability' -Name ShutdownReasonOn -Value 0 -Force


