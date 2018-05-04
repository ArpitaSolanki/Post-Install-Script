TIMEOUT 10
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
TIMEOUT 10
Invoke-WebRequest https://github.com/PowerShell/Win32-OpenSSH/releases/download/v1.0.0.0/OpenSSH-Win64.zip -OutFile "c:\Program Files\openssh.zip"
TIMEOUT 10
Expand-Archive 'c:\Program Files\openssh.zip' 'C:\Program Files\'
TIMEOUT 10
cd 'C:\Program Files\./OpenSSH-Win64\'
TIMEOUT 10
powershell.exe -ExecutionPolicy Bypass -File install-sshd.ps1
TIMEOUT 10
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
TIMEOUT 10
netsh advfirewall firewall add rule name=sshd dir=in action=allow protocol=TCP localport=sshd
TIMEOUT 10
Start-Service sshd
TIMEOUT 10
Powershell.exe -ExecutionPolicy Bypass -Command '. .\FixHostFilePermissions.ps1 -Confirm:$false'
Set-Service sshd -StartupType Automatic
Set-Service ssh-agent -StartupType Automatic
