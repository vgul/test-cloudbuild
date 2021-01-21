
# 6. Build configuration
# 
# 6.1. Run powershell as admin
# 6.2. Add a local user 'qa'
      net user qa qa /add
# 6.3. Add a local user 'qatest'
      net user qatest qatest /add
# 6.3.1. Configure qatest user. Run cygwin terminal using using build user.
# 6.3.1.1. Create home directory. Login via ssh.
#      ssh qatest@localhost
# 6.3.2.2. Logout from the above ssh session.
# 6.3.2.3. Add a public ssh key from build user
#     $ ssh-copy-id -i ~/.ssh/id_rsa.pub qatest@localhost
# 6.3.2.4. Make sure that key-based auth works
#     $ ssh qatest@localhost
# 6.4. Add network aliases required for successful windows agent tests related to mapped drives and active directory
# 6.4.1. Edit C:\Windows\System32\drivers\etc\hosts (or /c/Windows/System32/drivers/etc/hosts) and add the following aliases:
#     10.200.1.93 ec-dc-01 electric-cloud.com ec-dc-01.electric-cloud.com dir.electric-cloud.com
#     10.200.1.93 testspace1 testspace2
#     10.200.1.93 ecbuild-nfs-alias1
#     10.200.1.93 eng
# 
#         
