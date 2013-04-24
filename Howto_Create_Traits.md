# What are Traits
A trait defines a functionality or feature a minikrebs may have. 
Profiles are just a collection of traits which define the behavior of the minikrebs.

Traits are stored hierarchical and evaluated recursively. 
Every folder in traits can be a trait, even if it contains other trait folders. 

For example in traits/special_purpose:

    instacam
    instacam/MANIFEST
    instacam/zc3xx
    instacam/zc3xx/files/etc/config/mjpg-streamer
    instacam/zc3xx/MANIFEST
    instacam/uvc
    instacam/uvc/files/etc/config/mjpg-streamer
    instacam/uvc/files/etc/rc.local
    instacam/uvc/MANIFEST
    instacam/uvc/yuv
    instacam/uvc/yuv/files/etc/config/mjpg-streamer
    instacam/uvc/yuv/files/init.d/mjpg-streamer
    instacam/files
    instacam/files/etc/config/mjpg-streamer


the instacam folder contains MANIFEST but also subdirectories with special traits for 
special hardware or software.

# Creating Traits
A trait is a folder in the traits/ directory with at least one of the following two things:

1. a MANIFEST file
2. a files/ folder

## MANIFEST
The MANIFEST file may contain the following lines:

    PACKAGES=""   #space-separated list of openwrt packages
    DEPENDS=""    #space-separated list of traits which this trait depends on (not yet implemented)

## files/
All files and folders in the files/ folder will be copied in the root folder of the newly formed firmware

# core/ trait
the core/ trait contains basic simple additions to prepare the minikrebs for direct use 
(like setting the password or symlinking the authorized_keys file).

default password for the minikrebse is 'minikrebs'

## core/firstrun

firstrun is a trait which will run scripts in /etc/firstrun.d/ only on first run (for example 
preparing a root overlay, generating ssh keys or that kind of stuff).

When all scripts exited successfully, a /etc/firstrun.complete is created and the scripts will not be run again.

If one script failed at the first run ,for example if internet was unreachable but required for a script to run,
ALL scripts will be rerun at the next reboot. Make sure you write robust scripts which will not break when rerun.

to use firstrun, simply create a new trait and add your run-script in:

    files/etc/firstrun.d/23_my-fancy-trait


