

#!/bin/bash


function join_by { local d=$1; shift; local f=$1; shift; printf %s "$f" "${@/#/$d}"; }

FILESTORE='10.30.228.2:/chronic3build'

CMDS=(
  'powershell New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default" -Name "AnonymousUid" -Value "-2" -PropertyType DWORD'
  'powershell New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default" -Name "AnonymousGid" -Value  "0" -PropertyType DWORD'
  'cmd /K nfsadmin client stop'
  'cmd /K nfsadmin client start'
  "cmd /C mount ${FILESTORE} N:"
  "N:\\chronic3build\\commander-git-main-full-sqlserver2017.144984-202101050600\\out\\i686_win32\\nimbus\\install\\CloudBeesFlow-10.1.0.144984.exe \
  --installAgent \
  --installWeb \
  --installServer \
  --installDatabase \
  --installRepository \
  --windowsServerUser build  \
  --windowsServerPassword \":uVxNp=201>8\\9L\"  \
  --useSameServiceAccount  \
  --remoteServer localhost  \
  --overwrite \
  --mode silent"
  
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

echo "$CMD"

#exit 0

INSTANCE_NAME=win-spec-test01
DISK_SIZE=50GB
SUBNET="projects/ops-shared-vpc/regions/us-west2/subnetworks/testing-cloud-cd-us-west2"

gcloud beta compute  \
  instances create ${INSTANCE_NAME} \
  --hostname "${INSTANCE_NAME}.c.flow-testing-project.internal" \
  --project=flow-testing-project   \
  --description=desc \
  --zone=us-west2-a \
  --machine-type=e2-standard-4 \
  --subnet=${SUBNET} \
  --no-address \
  --metadata=windows-startup-script-cmd="$CMD",hostname=${INSTANCE_NAME} \
  --no-restart-on-failure  \
  --maintenance-policy=TERMINATE \
  --preemptible \
  --service-account=979098084317-compute@developer.gserviceaccount.com \
  --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
  --tags=cd-artemis-us-west2 \
  --image=win-spec-test-2021-01-04t13-36-36z \
  --image-project=flow-testing-project \
  --boot-disk-size=${DISK_SIZE} \
  --boot-disk-type=pd-standard \
  --boot-disk-device-name=win-spec-test01 \
  --no-shielded-secure-boot \
  --shielded-vtpm \
  --shielded-integrity-monitoring \
  --labels=here=label,here2=value2 \
  --reservation-affinity=any


