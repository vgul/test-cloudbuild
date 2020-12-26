

##############
# INSTALL IIS 
##############

Write-Host "Installing IIS and all Sub Features"
Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature

##############
#  GCESysprep
##############

GCESysprep -no_shutdown

