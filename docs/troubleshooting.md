# troubleshooting

## check wsl 2

Run from PowerShell:

```powershell
wsl --status
wsl --list --verbose
```

The second command shows the installed distributions and whether each one
uses WSL 1 or WSL 2. Update WSL if necessary:

```powershell
wsl --update
```

## wsl ssh connection times out

Make sure ssh is listening inside Ubuntu:

```bash
sudo ss -tlnp | grep ':2222'
sudo systemctl status ssh.service
```

Test it from Windows:

```powershell
Test-NetConnection -ComputerName localhost -Port 2222
```

If localhost works but another machine cannot connect, allow port 2222
through the Hyper-V firewall used by WSL mirrored networking. Run from an
elevated PowerShell:

```powershell
New-NetFirewallHyperVRule -Name "WSL-SSH" -DisplayName "WSL SSH" -Direction Inbound -VMCreatorId '{40E0AC32-46A5-438A-A0B2-2B479E8F2E90}' -Protocol TCP -LocalPorts 2222
```
