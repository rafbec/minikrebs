Customized OpenWRT image generator
==================================

Based on http://shackspace.de/wiki/doku.php?id=project:minikrebs 

Build image that contains a webradio client
-------------------------------------------

    # Get ready
    ./prepare radio
    # Build the firmware image
    ./builder/init
    # Flash to the device - this asks for the root password of the device twice, then reboots
    # Note: OpenWRT must already be running on the device
    ./upgrade 192.168.0.19 # replace with the IP address of the device

The device will get an IP address via DHCP on wired Ethernet, and default password is "minikrebs".

### Setting up WLAN client mode

* Wifi: Scan, Join Network, Create / Assign firewall-zone: select lan (green)!, Submit, Save and apply
* Interfaces -> WWAN -> Advanced settings -> Override MAC address: Has the WRONG IP, so set IP+1, Save and apply
* Interfaces: Both LAN and WWAN should be green now and both should have an IP address
* HTML interface should be reachable on both addresses

If you have totally mis-configured the network and can't get in anymore, use "OpenWRT Failsafe" (using an Ethernet cable and the reset button)

### Setting up radio stations and remote control codes
* http://192.168.0.19/cgi-bin/luci/admin/radio/stations
* http://192.168.0.19/cgi-bin/luci/admin/radio/remote
