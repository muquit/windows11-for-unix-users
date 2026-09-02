# docker and podman

Both Docker Desktop and Podman can run Linux containers with WSL 2. This
works on Windows 11 Home; you do not need the Hyper-V role or Windows 11 Pro.

## docker desktop

Install [Docker Desktop](https://docs.docker.com/desktop/setup/install/windows-install/)
and select the WSL 2 backend. To use `docker` from Ubuntu, open Docker
Desktop, go to **Settings > Resources > WSL Integration** and enable your
Ubuntu distribution. The command is also available from PowerShell after
Docker Desktop updates the Windows `PATH`.

## podman

Install [Podman Desktop](https://podman-desktop.io/docs/installation/windows-install)
and use the WSL 2 provider. The Hyper-V provider also works on Windows 11
Pro, but I do not need it.
