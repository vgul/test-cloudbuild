# 
# 4. Install cygwin
# 
# 4.1. Run powershell as admin
# 4.2. Run the following commands:
      choco install -y cygwin --params "/InstallDir:C:\cygwin64"
      c:\cygwin64\cygwinsetup.exe --quiet-mode --wait --packages "wget,curl,openssh,openssl,bash-completion,vim,binutils,git,p7zip,zip,unzip,rsync,autoconf,automake,makedepend,make,pkg-config,patch,perl,tcl,gettext-devel"
      Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $("c:\cygwin64\bin;" + (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path)
      Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $(((Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path.split(';',[System.StringSplitOptions]::RemoveEmptyEntries) -join ';') + ';c:\cygwin64\bin;')
# 4.3. Create desktop shortcut for cygwin. Run the following command:
      copy $([Environment]::GetFolderPath([System.Environment+SpecialFolder]::CommonPrograms) + '\Cygwin\Cygwin64 Terminal.lnk') $([Environment]::GetFolderPath("CommonDesktopDirectory"))

# Reload path
      $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") ; 
      echo $env:Path

# 4.4. Re-open powershell as admin
# 4.5. Run the following command:
      bash --login -i -c "ssh-host-config -y -u build -w Mbimp,vm"
      net start cygsshd
# 4.6. Fix cygdrive prefix
      bash --login -i -c "sed -i 's#none /cygdrive#none /#' /etc/fstab"
# 4.7. Create symlink for gmake
      bash --login -i -c "ln -s /bin/make /bin/gmake"
# 4.8. Generate SSH key
      bash --login -i -c "ssh-keygen -q -b 4095 -t rsa -N '' -f ~/.ssh/id_rsa"
      bash --login -i -c "cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys"
# 4.9. Make cygwin64 compatible with scripts which expect path c:\cygwin\
      cmd /c "mklink /j c:\cygwin c:\cygwin64"
#     
