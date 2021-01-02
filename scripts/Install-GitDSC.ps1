

Configuration InstallMSysGit {

  Import-DscResource –ModuleName 'PSDesiredStateConfiguration'

  Node localhost {

    Package MSysGit {
      Ensure    = 'Present'
      Name      = 'Git version 2.30.0'
      Path      = "${Env:UserProfile}\Downloads\Git-2.30.0-64-bit.exe"
      ProductId = ''
      Arguments = '/SILENT /COMPONENTS="icons,ext\reg\shellhere,assoc,assoc_sh"'
    }
  }
}
        


InstallMSysGit -OutputPath C:\

Start-DscConfiguration -ComputerName localhost -Path c:\ -Wait -Verbose -Force
