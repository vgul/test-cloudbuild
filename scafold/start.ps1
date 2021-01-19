echo "Os Started" >> C:\Cache\os-started

N:\\chronic3build\\commander-git-main-full-sqlserver2017.144909-202012211207\\out\\i686_win32\\nimbus\\install\\CloudBeesFlow-2020.12.0.144909.exe `
  --installAgent `
  --installWeb `
  --installServer `
  --installDatabase `
  --installRepository `
  --windowsServerUser build  `
  --windowsServerPassword '&[qg$S2gi{xuG1t' `
  --useSameServiceAccount  `
  --temp C:\Cache\ `
  --mode silent

echo "Flow installation finished" >> C:\Cache\flow-installation-finished
powershell 'do { Write-Host "waiting flow..." ; sleep 3 } until( Test-NetConnection localhost -Port 8443 | ? { $_.TcpTestSucceeded } )'

echo "Port 8443 is open" >> C:\Cache\port8443-open
ectool getServerStatus --block 1 --timeout 600
echo "getServerStatus" >> C:\Cache\get-server-status-ok

powershell Start-Sleep -s 10
N:\\chronic3build\\commander-git-main-full-sqlserver2017.144909-202012211207\\out\\i686_win32\\nimbus\\install\\CloudBeesFlowDevOpsInsightServer-x64-2020.12.0.144909.exe `
  --windowsServerUser build `
  --windowsServerPassword '&[qg$S2gi{xuG1t' `
  --remoteServer localhost `
  --remoteServerUser admin `
  --remoteServerPassword changeme `
  --temp C:\Cache\ `
  --mode silent
echo "DOIS installation finished" >> C:\Cache\dois-installation-finished
#powershell 'do { Write-Host "waiting flow..." ; sleep 3 } until( Test-NetConnection localhost -Port 9200 | ? { $_.TcpTestSucceeded } )'
#echo "Port 9200 is open" >> C:\Cache\port9200-open
