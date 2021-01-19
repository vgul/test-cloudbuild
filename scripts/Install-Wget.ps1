
Write-Host "Installing wget"


& .\Downloads\wget-1.11.4-1-setup.exe `
    /SILENT `
    /LOG=C:\Cache\wget-installation.log `
    *>&1 | Out-Default

if ($LastExitCode -ne 0) {
	throw "Wget installation failed with exit code $LastExitCode"
}

Write-Host "Wget installation finished`n`n"

$OldPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path

$NewPath = "${OldPath};C:\Program Files (x86)\GnuWin32\bin"

Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $NewPath



