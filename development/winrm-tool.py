from winrm import Protocol
import base64
import sys

address = "10.30.176.75"
#transport = "plaintext"
transport = "ntlm"
username = "build"
password = ':uVxNp=201>8\9L'

protocol = "http"
port = 5985

endpoint = "%s://%s:%s/wsman" % (protocol, address, port)

conn = Protocol(endpoint=endpoint, transport=transport, username=username, password=password)
shell_id = conn.open_shell()

def run_winrm(cmd):
    command_id = conn.run_command(shell_id, cmd) #"powershell -encodedcommand %s" % (encoded_script))
    stdout, stderr, return_code = conn.get_command_output(shell_id, command_id)
    conn.cleanup_command(shell_id, command_id)
    print ("STDOUT: %s" % (stdout.decode('cp1251')))
    #print ("STDOUT: %s" % (stdout.decode('utf-8')))
    #print ("STDERR: %s" % (stderr.decode('utf-8')))
    print ("STDERR: %s" % (stderr.decode('cp1251')))
    #print ("STDOUT: %s" % (stdout))
    #print ("STDERR: %s" % (stderr))

def copy_text_file(filename):
    with open(filename, mode='r') as file: # b is important -> binary
        file_content = file.read()#.decode('utf-8')


    #head = """$stream = [System.IO.StreamWriter]::new( "%s", 0, [System.Text.Utf8Encoding]::new())
    #head = """$stream = [System.IO.StreamWriter]::new( [Stream.Write], 0, [System.Text.Utf8Encoding]::new())
    head = """$stream = [System.IO.StreamWriter] "%s"
$s = @'
""" % filename

    tail = """
'@ 
$stream.WriteLine($s)
$stream.close()"""
#"@ | %{ $_.Replace("`n","`r`n") }
#    print(head)
#    print(tail)
    #print(file_content)
#    sys.exit(0)

    script = head + file_content + tail


    encoded_script = base64.b64encode(script.encode("utf_16_le")).decode('utf_8')
    #print (encoded_script)
    run_winrm("powershell -encodedcommand %s" % (encoded_script))





#copy_text_file("V.ps1")
#run_winrm("gsutil -m rsync gs://smurthy_cbcd_installers/packer-20201230/ .\Downloads")
#run_winrm("powershell Install-WindowsFeature -Name NFS-Client")
#run_winrm("powershell New-ItemProperty -Path \"HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default\" -Name \"AnonymousUid\" -Value \"0\" -PropertyType DWORD")
run_winrm("net use")
run_winrm("N:\\chronic3build\\commander-git-main-full-sqlserver2017.144984-202101050600\\out\\i686_win32\\nimbus\\install\\CloudBeesFlow-10.1.0.144984.exe --installAgent --installWeb --installServer --installDatabase --installRepository --windowsServerUser build --useSameServiceAccount --overwrite --mode silent ")
#run_winrm("net use N: \\\\10.30.228.2\\chronic3build")
#run_winrm("net use")
#run_winrm("dir N:\chronic3build\commander-git-main-full-sqlserver2017.144909-202012211207\out\\") #i686_win32\nimbus/install/CloudBeesFlow-2020.12.0.144909.exe")
#copy_text_file("Install-Java.bat")
#copy_text_file("java-install.properties")
#run_winrm(".\Install-Java.bat")

conn.close_shell(shell_id)
