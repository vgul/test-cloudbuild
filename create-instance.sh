

#!/bin/bash


#function join_by { local d=$1; shift; local f=$1; shift; printf %s "$f" "${@/#/$d}"; }
date

FILESTORE='10.30.228.2:/chronic3build'
IMAGE='win-spec-test-2021-01-14t20-54-02z'
INSTANCE_NAME=win-spec-test02
DISK_SIZE=50GB


CMDS2=(
  'powershell New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default" -Name "AnonymousUid" -Value "-2" -PropertyType DWORD'
  'powershell New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default" -Name "AnonymousGid" -Value  "0" -PropertyType DWORD'
  'cmd /K nfsadmin client stop'
  'cmd /K nfsadmin client start'
  "cmd /C mount ${FILESTORE} N:"
)

CMDS=(
  "echo \"Os Started\" >> C:\\Cache\\os-started"
  'cmd /K nfsadmin client stop'
  'cmd /K nfsadmin client start'
  "cmd /C mount ${FILESTORE} N:"

  "N:\\chronic3build\\commander-git-main-full-sqlserver2017.144909-202012211207\\out\\i686_win32\\nimbus\\install\\CloudBeesFlow-2020.12.0.144909.exe \
  --installAgent \
  --installWeb \
  --installServer \
  --installDatabase \
  --installRepository \
  --windowsServerUser build  \
  --windowsServerPassword \"&[qg\$S2gi{xuG1t\" \
  --useSameServiceAccount  \
  --temp C:\\Cache\\ \
  --mode silent"

  "echo \"Flow installation finished\" >> C:\\Cache\\flow-installation-finished"
  'powershell -command "do { Write-Host \"waiting flow...\" ; sleep 3 } until( Test-NetConnection localhost -Port 8443 | ? { $_.TcpTestSucceeded } )"'

  "echo \"Port 8443 is open\" > C:\\Cache\\port8443-open"

  "powershell \"Start-Sleep -s 150\""
  'powershell "$env:Path = [System.Environment]::GetEnvironmentVariable(\"Path\",\"Machine\") + \";\" + [System.Environment]::GetEnvironmentVariable(\"Path\",\"User\") ; echo $env:Path ; ectool getServerStatus --block 1 --timeout 600 "'

  "echo cmd /C \"ectool getServerStatus --block 1 --timeout 600\""
  "echo \"getServerStatus\" >> C:\\Cache\\get-server-status-ok"

  "powershell \"Start-Sleep -s 10\""


  "N:\\chronic3build\\commander-git-main-full-sqlserver2017.144909-202012211207\\out\\i686_win32\\nimbus\\install\\CloudBeesFlowDevOpsInsightServer-x64-2020.12.0.144909.exe \
  --windowsServerUser build \
  --windowsServerPassword \"&[qg\$S2gi{xuG1t\" \
  --remoteServer localhost \
  --remoteServerUser admin \
  --remoteServerPassword changeme \
  --temp C:\\Cache\\ \
  --mode silent"
  "echo \"DOIS installation finished\" >> C:\\Cache\\dois-installation-finished"


#robocopy D:\исходная_папка \\192.168.0.1\целевая_папка /E /Z /COPY:TDASO /DCOPY:T /M /R:2 /W:5  /MT:64
#ROBOCOPY /e /b /xj /r:2 /w:5 /v /it /purge /copyall "\\its-fp1old\f$\Magic Fridge" "f:\Fdfs\Magic Fridge" /xd DfsrPrivate .TemporaryItems /xf .ds_store /tee /log:c:\miglogs\Fmagicfridge.log

)


OLDIFS="$IFS"
IFS=
CMD=
for L in ${CMDS[@]}; do
  if [ -z $CMD ]; then
    CMD="$L"
  else
    CMD="${CMD} & $L"
  fi
done
IFS="$OLDIFS"

echo
echo "CMD=$CMD"
echo
#exit 0

SUBNET="projects/ops-shared-vpc/regions/us-west2/subnetworks/testing-cloud-cd-us-west2"

  #--hostname "${INSTANCE_NAME}.c.flow-testing-project.internal" \
  #hostname=${INSTANCE_NAME} \


gcloud beta compute  \
  instances create ${INSTANCE_NAME} \
  --project=flow-testing-project   \
  --description=desc \
  --zone=us-west2-a \
  --machine-type=e2-standard-8 \
  --subnet=${SUBNET} \
  --no-address \
  --metadata=^DELIM^windows-startup-script-cmd="$CMD" \
  --no-restart-on-failure  \
  --maintenance-policy=TERMINATE \
  --preemptible \
  --service-account=979098084317-compute@developer.gserviceaccount.com \
  --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
  --tags=cd-artemis-us-west2 \
  --image=${IMAGE} \
  --image-project=flow-testing-project \
  --boot-disk-size=${DISK_SIZE} \
  --boot-disk-type=pd-standard \
  --boot-disk-device-name=win-spec-test01 \
  --no-shielded-secure-boot \
  --shielded-vtpm \
  --shielded-integrity-monitoring \
  --labels=here=label,here2=value2 \
  --reservation-affinity=any

## gcloud compute project-info add-metadata \
##    --metadata serial-port-enable=TRUE
