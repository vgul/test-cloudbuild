
Write-Host "Installing WinSCP"


& .\Downloads\WinSCP-5.17.9-Setup.exe `
    /ALLUSERS `
    /VERYSILENT `
    /NORESTART `
    /LOG=C:\Cache\winscp-installation.log `
    *>&1 | Out-Default

if ($LastExitCode -ne 0) {
	throw "WinSCP installation failed with exit code $LastExitCode"
}

Write-Host "WinSCP installation finished`n`n"

