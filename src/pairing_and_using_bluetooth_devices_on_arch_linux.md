---
author: Taha Azzaoui
date: 2018-10-30
title: Paring and Using Bluetooth Devices on Arch Linux
categories:
    - linux
---

# Intro
Bluetooth is one of those things that's always been a pain to set up in Linux. 
This is partly because of the Bluetooth stack and how it interacts with
the kernel. The architecture is essentially split between user and
kernel space, where the kernel takes care of things like low level protocols
(RFCOMM), security, and hardware drivers leaving the central daemon, `blutoothd`
and command line agent `bluetoothctl` up in user space. For more on how this
it works, check out the source code here:
[https://github.com/torvalds/linux/tree/master/drivers/bluetooth](https://github.com/torvalds/linux/tree/master/drivers/bluetooth)

# Getting the client
1. Since [BlueZ](http://www.bluez.org/) is the de facto Bluetooth protocol stack in Linux, we'll start by
   grabbing that
   
    > `sudo pacman -S bluez bluez-utils`
 
2. Next, we'll need a Bluetooth client. Blueman is pretty minimal and easy to
   use, so we'll go with that
   
    > `sudo pacman -S blueman`

# Kernel Support 
I'm assuming we're configuring Bluetooth on a laptop with a built in radio. In
this case, the driver should be automatically loaded. In case you're using a USB
Bluetooth dongle, you can manually load the driver as follows:

> `sudo modprobe btusb`


# Configuring the Client

1. Start the Bluetooth service

   > `sudo systemctl start bluetooth.service`
   
   Note that if you wish to start the service on boot up, you can enable it as
   well
   
   > `sudo systemctl enable bluetooth.service`

2. Start the client
   
   > `bluetoothctl`
   
   You'll then be greeted with a prompt. We'll interact with it as follows
   
   > ``[bluetooth]# power on``
   
   > ``[bluetooth]# agent on``
   
   > ``[bluetooth]# default-agent``
   
   Now we'll scan for a device. Be sure to put your Bluetooth device in pairing mode.
   
   > ``[bluetooth]# scan on``
   
   > Output: [NEW] Device 00:18:09:9B:A1:DD MDR-XB650BT
   
   Now copy the MAC Address of the device and pair with it as follows
   
   > ``[bluetooth]# pair 00:18:09:9B:A1:DD``
   
   Once we're paired with the device, we can connect to it like so
   
   > ``[bluetooth]# connect  00:1D:43:6D:03:26``
   
   Once we're connected, we can turn off scanning mode and quit the program
   
   > ``[bluetooth]# scan off``
   
   > ``[bluetooth]# exit``


# A Note on Sound Quality
Many people complain about poor sound quality when using Bluetooth headsets.
This is usually a problem with high fidelity playback. To solve this problem
simply switch to A2DP instead as follows

List the audio cards on your system

> pacmd list-cards

Make note of the card number of your Bluetooth device and substitute it in the
command below to make the switch

> pacmd set-card-profile <card #> a2dpsink

Finally, make sure the device is recognized

> pacmd set-sink-volume 0 0
