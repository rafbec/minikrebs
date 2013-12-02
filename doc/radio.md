Webradio client
===============

This is a webradio client for a TP-LINK TL-WR703N with (optional) an Arduino connected that has a TSOP and an IR LED connected and can receive and send IR signals.

The device will get an IP address via DHCP on wired Ethernet, and you can set up WLAN client mode so that you don't need wired Ethernet any more.

### Setting up WLAN client mode

* Wifi: Scan, Join Network, Create / Assign firewall-zone: select lan (green)!, Submit, Save and apply
* Interfaces -> WWAN -> Advanced settings -> Override MAC address: Has the WRONG IP, so set IP+1, Save and apply
* Interfaces: Both LAN and WWAN should be green now and both should have an IP address
* HTML interface should be reachable on both addresses

If you have totally mis-configured the network and can't get in anymore, use "OpenWRT Failsafe" (using an Ethernet cable and the reset button)

### Setting up radio stations and remote control codes
* http://192.168.0.19/cgi-bin/luci/admin/radio/stations
* http://192.168.0.19/cgi-bin/luci/admin/radio/remote (this is for a 3.3V 16MHz Arduino to be hooked up to the router)

TODO
----

* Get rid of the Arduino, use LIRC to receive and send IR codes, e.g., using lirc_rpi(?)
