
Write-Host "Installing Timethis utility"


& .\Downloads\timethis_setup.exe /Q *>&1 | Out-Default

if ($LastExitCode -ne 0) {
	throw "Time utility (timethis) installation failed with exit code $LastExitCode"
}

Write-Host "Java installation finished`n`n"

Copy-Item 'C:\Program Files (x86)\Resource Kit\TIMETHIS.EXE' -Destination "${env:WinDir}\\System32"

