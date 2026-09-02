# prevent windows 11 from sleeping

If you use ssh or RDP, the Windows machine must stay awake. Turning off the
display is fine; putting the computer to sleep disconnects it from the
network.

Go to **Settings > System > Power & battery > Screen, sleep & hibernate
timeouts** and set the sleep and hibernate timers to **Never**.

On a laptop, also open **Control Panel > Hardware and Sound > Power Options >
Choose what closing the lid does** and set **When I close the lid** to **Do
nothing**.

If the machine still sleeps, check the vendor's power application. On my
Lenovo laptop, I also check Lenovo Vantage.

If the machine remains awake but ssh or RDP disconnects, open the network
adapter in Device Manager. If it has a **Power Management** tab, uncheck
**Allow the computer to turn off this device to save power**.
