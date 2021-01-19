
Write-Host "Installing Cygwin"


& .\Downloads\cygwin\setup-x86_64.exe `
    --quiet-mode `
    --site https://mirrors.kernel.org/sourceware/ `
    --root C:\cygwin64 `
    --packages `
        bzip2,`
        make,`
        dos2unix,`
        unzip,`
        wget,`
        curl,`
        nano,`
        vim,`
        git `
    *>&1 | Out-Default

if ($LastExitCode -ne 0) {
	throw "Cygwin installation failed with exit code $LastExitCode"
}

Write-Host "Cygwin installation finished`n`n"

#$OldPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
#$NewPath = "${OldPath};C:\Program Files (x86)\GnuWin32\bin"
#Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $NewPath



