Customized OpenWRT image generator
==================================

Based on http://shackspace.de/wiki/doku.php?id=project:minikrebs 

Build image that contains a webradio client
-------------------------------------------

    # If you want to build for a device other than the TP-LINK TL-WR703N, do:
    export PLATFORM=DIR505A1 # for D-Link DIR-505
    # Get ready
    ./prepare radio
    # Build the firmware image
    ./builder/init
    # Flash to the device - this asks for the root password of the device twice, then reboots
    # Note: OpenWRT must already be running on the device
    ./upgrade 192.168.0.19 # replace with the IP address of the device

For more information see doc/radio.md
