from winrm import Protocol
import base64
import sys

address = "10.30.176.108"
#transport = "plaintext"
transport = "ntlm"
username = "build"
password = 'P7C[Lg),AS8|wk+'
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





copy_text_file("V.ps1")
#run_winrm("gsutil -m rsync gs://smurthy_cbcd_installers/packer-20201230/ .\Downloads")
run_winrm("powershell.exe -executionPolicy bypass .\V.ps1")
#copy_text_file("Install-Java.bat")
#copy_text_file("java-install.properties")
#run_winrm(".\Install-Java.bat")

conn.close_shell(shell_id)



sys.exit(0)
# the text file we want to send
# this could be populated by reading a file from disk instead
# has some special characters, just to prove they won't be a problem
text_file = """this is a multiline file
that contains special characters such as
"blah"
'#@$*&&($}
that will be written
onto the windows box"""

filename = "s1.ps1"
with open(filename, mode='r') as file: # b is important -> binary
        file_content = file.read()

print( file_content)

# first part of the powershell script
# streamwriter is the fastest and most efficient way to write a file
# I have found
# notice the @", this is like a "here document" in linux
# or like triple quotes in python and allows for multiline files
part_1 = """$stream = [System.IO.StreamWriter] "test.cmd"
$s = @"
"""

# second part of the powershell script
# the "@ closes the string
# the replace will change the linux line feed to the windows carriage return, line feed
part_2 = """
"@ | %{ $_.Replace("`n","`r`n") }
$stream.WriteLine($s)
$stream.close()"""

# join the beginning of the powershell script with the text file and end of the ps script
script = part_1 + file_content + part_2

# base64 encode, utf16 little endian. required for windows
encoded_script = base64.b64encode(script.encode("utf_16_le")).decode('utf-8')


    

run_winrm("powershell -encodedcommand %s" % (encoded_script))
run_winrm("test.cmd")
#run_winrm("type test.txt")
#run_winrm("del test.txt")

# always good to clean things up, doesn't hurt

sys.exit(0)

