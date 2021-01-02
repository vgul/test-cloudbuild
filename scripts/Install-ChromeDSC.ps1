

Configuration InstallGChrome {

  Import-DscResource –ModuleName 'PSDesiredStateConfiguration'

  Node localhost {

    Package GChrome {
      Ensure    = 'Present'
      Name      = 'Google Chrome'
      Path      = "${Env:UserProfile}\Downloads\ChromeStandaloneSetup64.exe"
      ProductId = ''
      Arguments = '/silent /install'
    }
  }
}
        


InstallGChrome -OutputPath C:\

Start-DscConfiguration -ComputerName localhost -Path c:\ -Wait -Verbose -Force
