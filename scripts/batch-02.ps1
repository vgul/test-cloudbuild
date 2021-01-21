# 
# 1. Install Chocolatey (https://chocolatey.org/install)
# 
# 1.1. Run powershell as admin
# 1.2. Run the following command:
      Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
#
# 2. Install third-party software
# 
# 2.1. Run powershell as admin
# 2.2. Run the following command:
      choco install -y notepadplusplus dependencywalker winmerge googlechrome procexp accessenum tcpview diskmon junction handle scanner procmon
# 2.3. Install psexec (this package was outdated in my case, thus I have to use '--ignore-checksums' option)
      choco install -y --ignore-checksums psexec
# 2.4. Disable Chrome's auto-update services
      Set-Service gupdate -StartupType Disabled
      Stop-Service gupdate
#     Set-Service gupdatem -StartupType Disabled
#     Stop-Service gupdatem
# 
# 3. Create desktop shortcuts for the third-party software
# 
# 3.1. Run powershell as admin
# 3.2. Run the following commands:
      copy $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms) + '\Notepad++.lnk') $([Environment]::GetFolderPath("CommonDesktopDirectory"))
      copy $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms) + '\WinMerge\WinMerge.lnk') $([Environment]::GetFolderPath("CommonDesktopDirectory"))
      copy $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms) + '\Process Explorer.lnk') $([Environment]::GetFolderPath("CommonDesktopDirectory"))
      copy $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms) + '\Process Monitor.lnk') $([Environment]::GetFolderPath("CommonDesktopDirectory"))
      copy $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms) + '\Administrative Tools\Windows PowerShell.lnk') $([Environment]::GetFolderPath("CommonDesktopDirectory"))
      copy $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms) + '\Administrative Tools\Services.lnk') $([Environment]::GetFolderPath("CommonDesktopDirectory"))
      New-Item -ItemType SymbolicLink -Path $([Environment]::GetFolderPath("CommonDesktopDirectory")) -Name "Scanner" -Value 'C:\ProgramData\chocolatey\lib\scanner\tools\Scanner.exe'
