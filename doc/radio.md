Webradio client
===============

Quick Start
-----------

This is a webradio client for a TP-LINK TL-WR703N with (optional) an Arduino connected that has a TSOP and an IR LED connected and can receive and send IR signals.

The device will get an IP address via DHCP on wired Ethernet, and you can set up WLAN client mode so that you don't need wired Ethernet any more.

### Setting up WLAN client mode

* Wifi: Scan, Join Network, ~~Create / Assign firewall-zone: select lan (green)!,~~ Submit, Save and apply
* Interfaces -> WWAN -> Advanced settings -> Override MAC address: Has the WRONG IP, so set IP+1, Save and apply
* No longer needed since firewall packet is removed  ~~Interfaces: Both LAN and WWAN should be green now and both should have an IP address~~
* HTML interface should be reachable on both addresses

If you have totally mis-configured the network and can't get in anymore, use "OpenWrt Failsafe" (using an Ethernet cable and the reset button)

### Controlling over the web interface
* http://192.168.0.19/cgi-bin/radio

### Setting up radio stations and remote control codes
* http://192.168.0.19/cgi-bin/luci/admin/radio/stations
* http://192.168.0.19/cgi-bin/luci/admin/radio/remote (this is for a 3.3V 16MHz Arduino to be hooked up to the router)

TODO
----

* Make the microcontroller optional while stil having IR control capability, use LIRC to receive and send IR codes, e.g., using http://www.lirc.org/ir-audio.html

Documentation
=============

Purpose
-------

The purpose of this trait is to create a web radio player and podcast receiver. The hardware is based of a cheap router, which can easily be obtained on eBay at around 20 USD. Its unique features are:
- Play web radio streams
- Play podcasts
- Connect wired ethernet or wireless LAN
- Use station IDs/jingles or spoken announcements to identify the radio stream
- Flip through predefined channels and podcasts using a regular infrared remote control
- Use an HTML interface to control the player from any computer or mobile device in the household
- Search for and play MP3 music files on the Internet
- Search for and play radio stations and podcasts 
- Discover radio stations and podcasts using a server-based repository of radio stations and podcasts
- Find and play podcast episodes
- Sleep timer
- Optionally, send infrared remote control codes to other devices, e.g. an amplifier

Additional features are planned for the future and can be included relatively easily, such as:
- Optionally, switch on and off electrical outlets
- Send temperature and other sensor data to a central server
- Script complex infrared control sequences for scenario-based home entertainment control
- Communicate with and update the firmware of an attached Arduino for even more customization
- Execute custom actions on the Arduino from a web interface
- Multiroom synchronization
- PA announcements, e.g. for incoming calls or other events in home automation systems
- Server-based management of podcast subscriptions, episodes already listened to, and radio stations

Hardware
--------

The following hardware is the currently known minimum requirement:
- TP-LINK TP-703n, approximately 20 USD shipped (TP-702n is known NOT to work)
- USB 2.0 soundcard, approximately 2 USD shipped

The following hardware is optional:
- More powerful router, e.g., D-Link DIR-505 instead of the TP-LINK TP-703n. Note that the router needs to be supported by OpenWrt and needs to have a USB port
- An infrared remote control receiver, e.g. 5V TSOP
- An infrared LED for sending infrared signals
- An ATmega328P microcontroller and a 16 MHz crystal
- Soldering equipment

Development environment
-----------------------

This project uses minikrebs, A custom firmware generator for OpenWrt, in order to create custom firmware images that can be uploaded to the target router from the web interface. This effectively turns the wireless router into a general embedded Linux system. The code contained in this repository assembles the required firmware from both precompiled binaries contained in public repositories as well as custom scripts specifically written for the web radio application.

The radio application itself is written purely in shell scripts, which makes it really easy to understand and customize, while at the same time limiting the overhead and footprint of the system to a bare minimum.

Other parts of the OpenWrt web interface are written in lua, which could also be used for the web radio application. However we have chosen not to do so in order to avoid the overhead, should we choose to remove the OpenWrt web interface in a future version in order to save space.

The web interface itself makes use of well-known frameworks, such as jQuery and Bootstrap. These are loaded from CDNs in order to save space on the device.

Architecture
------------

The web radio application consists of the following main components:
- /usr/bin/radioplayer. This is a script which essentially runs an infinite loop that checks which title has to be played next, and plays that title
- /usr/bin/arduinolisten. This is a script that reads from an optionally connected ATmega328P microcontroller over the serial line, and reacts accordingly to commands which are coming, e.g., from and infrared receiver connected to the microcontroller
- /etc/init.d/radio. This is a start up script that launches radioplayer and arduinolisten
- /www/cgi-bin/radio. This is the web interface for the web radio application

In addition to these main components, A couple of additional scripts exist. However the ones explained above are responsible for the core functionality of the application. All of the above are pure shell scripts which can easily be read and modified.

In addition to these scripts, a couple of configuration files are critical:
- /etc/inittab. Normally a login shell is spawned on the serial console, Which interferes with the microcontroller that is connected there. Hence we have to deactivate it
- /etc/configuration/radio. This contains all configuration for the web radio application and is managed by the uci command of OpenWrt

Operation
---------

This paragraph describes key aspects of the mode of operation of the application. 

During bootup of the device, the init scripts are started. Among them is the radio script, which launches the arduinolisten script and the radioplayer script. The radioplayer script checks whether and USB sound card is present and a network connection is available, and then plays the startup sound. It then checks the configuration data for what has to be played next, and plays that tile using a combination of wget and madplay. Whenever the madplay process is killed, it checks what title has to be played next and plays that title. It also contains some logic to parse playlist files and to extract the URLs of the actual MP3 files from there.

The radio CGI script can be accessed by the user at http://192.168.0.19/cgi-bin/radio. It changes the configuration data according to user input. If required, it also kills the madplay process in order for the radio player script to pick up the configuration change and play the next title.

The arduinolisten script watches the serial connection for commands coming from the microcontroller, and changes the configuration data specifying the title that has to be played next. If required, it also kills the madplay process in order for the radio player script to pick up the configuration change and play the next title. 

If other input methods then an infrared receiver is connected to the microcontroller or the web interface are needed, these input methods need to replicate the behavior of the radio CGI script or the arduinolisten script.
