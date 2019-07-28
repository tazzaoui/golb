---
author: Taha Azzaoui
date: 2019-01-10
title: Replacing my Thinkpad's Boot Logo With Memes
categories:
    - linux
---

![](/images/thiccpad_boot_logo.jpg)

# Introduction

I recently went about updating the BIOS on my laptop and found out that Lenovo
makes it super easy to replace the stock boot image with something of your own.
Here's how I went about doing it. For reference, my machine is a 5th Gen 
Thinkpad X1 Carbon and my operating system is Arch Linux (I use arch btw). 
Note that this works with most modern Lenovo laptops as well.

# The Image

First thing's first, we need an image. The requirements are that the image must
be less than 60K. Furthermore, the image format must be either .BMP, .JPG, or .GIF. 
The one I used can be found [here](images/LOGO.GIF).

# Downloading the BIOS update

Head over to Lenovo's website and download the latest BIOS update for your
machine. Make sure to get the Bootable CD version (ISO). The link for the Carbon
can be found [here](https://support.lenovo.com/us/en/downloads/ds030685).

# Extract the BIOS Image

Next, we need to extract the contents of the BIOS image to add 
our custom boot logo. For this, we need a program called
[geteltorito](https://aur.archlinux.org/packages/geteltorito/). It's available in the AUR.

> `$ yay -S geteltorito`

Next we can use it to extract the image:

> `$ geteltorito.pl -o x1bios.img /path/to/bios/update.iso`


# Mount the BIOS Image

Next, to mount the image, we need to find the starting block's offset.
We can use the following command to find it.

> `$ file -sk x1bios.img | sed -r 's/.*startsector ([0-9]+).*/\1/'`

In my case, the block offset is 32. Using this information, we can now mount the image. 

> `\$ mount -oloop,offset=$((32 * 512)) x1bios.img /mnt`

Now that it's mounted, move the custom logo into the *Flash* directory. Make
sure the file name is LOGO.

> `$ cp LOGO.GIF /mnt/Flash`

Once that's done, we can unmount the image

> `$ umount /mnt`

# Flashing the Image

The next step is to flash the custom image onto a USB drive and boot from it.
Plug it in and flash the image as follows.

> `$ dd if=x1bios.img of=/dev/sdX bs=512K`

Once that's done, boot from the USB drive and follow the prompts. The update
should only take a few minutes and the custom logo will be automatically applied.
