# shell and ssh

## git bash

Install @GITBASH@. It gives you bash, git, ssh and many familiar Unix
commands. This alone makes Windows much more usable for me.

Git Bash is not a complete Linux environment. Use WSL 2 when you need one.

## ssh into windows

Windows 11 includes an optional OpenSSH server. Go to **Settings > System >
Optional features**, select **View features**, search for **OpenSSH Server**
and install it.

You can also install it from an elevated PowerShell:

```powershell
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```

If that command or the Settings application hangs, try DISM:

```powershell
DISM /Online /Add-Capability /CapabilityName:OpenSSH.Server~~~~0.0.1.0
```

Start the service and arrange for it to start with Windows:

```powershell
Start-Service sshd
Set-Service -Name sshd -StartupType Automatic
```

Test it from another machine:

```bash
ssh username@<windows-ip-or-tailscale-name>
```

The default shell is `cmd.exe`.

### make git bash the default ssh shell

Windows OpenSSH reads its default shell from the registry. Run the following
commands from an elevated PowerShell:

```powershell
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Program Files\Git\bin\bash.exe" -PropertyType String -Force
Restart-Service sshd
```

Adjust the path if Git Bash is installed elsewhere. Log in again and you
should get bash instead of Command Prompt.

This setting affects every OpenSSH login to the Windows host. You can still
run `cmd.exe` or `powershell.exe` from bash. To restore the default, use:

```powershell
Remove-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell
Restart-Service sshd
```

## wsl 2 and ubuntu

From an elevated PowerShell, install WSL 2 and Ubuntu:

```powershell
wsl --install -d Ubuntu
```

Restart Windows if requested, launch Ubuntu and create your Linux user. You
can return to it later by running `wsl` from PowerShell or Windows Terminal.

![Windows Terminal running Ubuntu](images/windows_terminal.png "Windows Terminal")

## ssh into wsl 2 directly

Running `bash` after logging in to Windows starts Git Bash, not Ubuntu. If
you want to log directly into Ubuntu, install its own OpenSSH server:

```bash
sudo apt update
sudo apt install openssh-server
sudo systemctl enable --now ssh
```

Recent WSL installations enable systemd by default. Check it with:

```bash
systemctl is-system-running
```

If systemd is not enabled, add this to `/etc/wsl.conf`:

```ini
[boot]
systemd=true
```

Then run `wsl --shutdown` from PowerShell and launch Ubuntu again.

### use mirrored networking

By default, WSL 2 uses NAT and its virtual-machine IP address can change.
Windows 11 22H2 and later support mirrored networking, which makes services
in WSL directly reachable from the LAN and generally works better with VPNs.

Create `%UserProfile%\.wslconfig` on Windows:

```ini
[wsl2]
networkingMode=mirrored
```

Restart WSL from PowerShell:

```powershell
wsl --shutdown
```

If the connection times out, see [wsl ssh connection times out](#wsl-ssh-connection-times-out).

### move the wsl ssh server to port 2222

Windows OpenSSH normally uses port 22. I use port 2222 for the ssh server in
Ubuntu so it is always clear which system I am connecting to.

Edit `/etc/ssh/sshd_config` in Ubuntu and add:

```text
Port 2222
```

Ubuntu may use systemd socket activation for ssh. The socket can continue to
listen on port 22 even after changing `sshd_config`. Disable the socket and
enable the regular service:

```bash
sudo systemctl disable --now ssh.socket
sudo systemctl enable --now ssh.service
sudo systemctl restart ssh.service
```

Confirm that Ubuntu is listening on port 2222:

```bash
sudo ss -tlnp | grep ':2222'
```

Then connect from another machine:

```bash
ssh -p 2222 username@<windows-ip-or-tailscale-name>
```

Port 22 should reach Windows and port 2222 should reach Ubuntu.

### password authentication

If login fails with `Permission denied`, inspect the effective setting:

```bash
sudo sshd -T | grep passwordauthentication
```

If necessary, set the following in `/etc/ssh/sshd_config` and restart ssh:

```text
PasswordAuthentication yes
```

```bash
sudo systemctl restart ssh.service
```
