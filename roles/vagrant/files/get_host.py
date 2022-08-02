import subprocess
cmd = subprocess.Popen('vagrant ssh-config --machine-readable', shell=True, stdout=subprocess.PIPE)
b = cmd.stdout.read().decode("utf-8")
for row in b.split('\n'):
    line = row.strip()
    if line.startswith('HostName'):
        host = line.split(' ')[1]
        print(host)
