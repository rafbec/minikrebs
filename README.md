Customized OpenWrt image generator
==================================

This is a customized OpenWrt firmware image generator based on http://shackspace.de/wiki/doku.php?id=project:minikrebs 

Build image that contains a web radio and podcast client
--------------------------------------------------------

You can use this firmware image generator to produce a firmware that does the following:
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

```
    # If you want to build for a device other than the TP-LINK TL-WR703N, do:
    export PLATFORM=DIR505A1 # for D-Link DIR-505
    # Get ready
    ./prepare radio
    # Build the firmware image
    ./builder/init
    # Flash to the device - this asks for the root password of the device twice, then reboots
    # Note: OpenWRT must already be running on the device
    ./upgrade 192.168.0.19 # replace with the IP address of the device
```

For more information see doc/radio.md
