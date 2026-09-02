# windows 11 for unix users

These are my notes on setting up a Windows 11 machine for someone coming
from Unix, Linux or macOS.

Without a proper shell, ssh and a real Linux environment, Windows is mostly
useless to me. I do not use Office or many native Windows applications, but
at times I need Windows for my various open source projects.

I cleaned up my setup notes so my Unix/Mac friends can use them without
repeating the same trial and error. I hope you find them useful as well.

This document covers the following:

* A usable bash shell with @GITBASH@
* ssh access to Windows
* An Ubuntu environment with WSL 2, also reachable over ssh
* Docker and Podman
* Remote Desktop access from Linux or Mac
* Compiling native Windows programs with @MINGW64@ or @VISUAL_STUDIO@
