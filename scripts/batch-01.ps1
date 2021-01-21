# 1. Initial configuration
#
# 1.1. Run powershell as admin
# 1.2. Install NFS support
     Install-WindowsFeature -Name NFS-Client
# 1.3. Set UID/GID for NFS connects
     reg add HKLM\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default /f /t REG_DWORD /v AnonymousUid /d 1004
     reg add HKLM\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default /f /t REG_DWORD /v AnonymousGid /d 1005
#    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default" -Name "AnonymousUid\" -Value "1004" -PropertyType DWORD
#    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default" -Name "AnonymousGid" -Value  "1005" -PropertyType DWORD
# 1.4. Create a script for persistent mounts
     mkdir  c:\tools -Force
     "mount 10.30.228.2:/chronic3build n:" | Out-File -Encoding ASCII "c:\tools\mount_shares.cmd"
#    "mount 10.222.22.210:/flow_tools t:"  | Out-File -Encoding ASCII -Append "c:\tools\mount_shares.cmd"
     "subst o: C:/cygwin64/usr/local"      | Out-File -Encoding ASCII -Append "c:\tools\mount_shares.cmd"
# 1.5. Create a task for persistent mounts
     schtasks /create /ru SYSTEM /sc ONSTART /tn "ArtemisMountShares" /tr "c:\tools\mount_shares.cmd" /f
# 1.6. Set timezone to "Pacific Standard Time"
     tzutil /s "Pacific Standard Time" 
# 1.7. Disable IPv6
     New-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\" -Name DisabledComponents -Value 0xFF -PropertyType DWord -ErrorAction SilentlyContinue
# 1.8. Show hidden files in explorer
     reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f
     reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSuperHidden /t REG_DWORD /d 1 /f
# 1.9. Resolve an issue with elevated processes and mapped drives 
     reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLinkedConnections /t REG_DWORD /d 1 /f
# 1.10. Activate "High Performance" power plan
     powercfg.exe /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
# 1.11. Disable Distributed File System (DFS) ( https://docs.cloud.oracle.com/en-us/iaas/Content/File/Troubleshooting/winNFSerror53.htm#Access_to_File_System_using_UNC_Path_is_Slow_or_Fails )
     reg add "HKLM\System\CurrentControlSet\Services\Mup" /v DisableDFS /t REG_DWORD /d 1 /f

# 1.10. Restart
#    PS > shutdown /r
#1.11. Check configuration
#1.11.1. Make sure the shared drives n: and t: available after restart
#1.11.2. Make sure that IPv6 disabled by running "ipconfig /all"
#1.11.3. Make sure that timezone is correct
