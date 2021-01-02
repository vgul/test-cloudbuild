

Configuration InstallGVim {

  Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

  Node localhost {

    Package GVim {
      Ensure    = 'Present'
      Name      = 'Vim 8.2 (x64)'
      Path      = "${Env:UserProfile}\Downloads\gvim_8.2.2257_x64.exe"
      ProductId = ''
      Arguments = '/S'
    }
  }
}
        


InstallGVim -OutputPath C:\

Start-DscConfiguration -ComputerName localhost -Path c:\ -Wait -Verbose -Force
