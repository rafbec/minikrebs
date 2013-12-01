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
    ./upgrade 192.168.0.19
