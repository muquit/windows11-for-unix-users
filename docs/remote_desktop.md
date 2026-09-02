# remote desktop

Windows 11 Pro, Enterprise and Education can accept Remote Desktop (RDP)
connections. Windows 11 Home includes the client but cannot act as an RDP
server.

## enable remote desktop on windows

Go to **Settings > System > Remote Desktop** and turn on **Remote Desktop**.

## connect from linux

### freerdp

I mostly use `xfreerdp3` from an Ubuntu desktop:

```bash
sudo apt install freerdp3-x11
xfreerdp3 /u:youruser /v:<windows-ip-or-tailscale-name>
```

### remmina

If you prefer a GUI, install @REMMINA@:

```bash
sudo apt install remmina remmina-plugin-rdp
```

## connect from mac

Install [Windows App](https://apps.apple.com/app/windows-app/id1295203466),
formerly called Microsoft Remote Desktop, from the App Store. Add a PC using
the Windows IP address or Tailscale name.

For day-to-day work I use ssh. RDP is mainly useful when I need the Windows
desktop, Device Manager, Lenovo Vantage or a GUI installer. If the machine
becomes unreachable after a while, see
[prevent windows 11 from sleeping](#prevent-windows-11-from-sleeping).
