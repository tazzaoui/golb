---
Author: Taha Azzaoui
Date: Thu Dec 27 13:46:38 EST 2018
Title: Gentoo Install Notes
---

My notes on installing Gentoo with disk encryption using LUKS

1. Prepare the disks 
    * `root@localhost # parted -a optimal /dev/sdn`

    * `(parted) unit mib`

    * `(parted) mklabel gpt`

    * Create a BIOS Partition
       * `(parted) mkpart primary 1 3`
       * `(parted) name 1 grub`
       * `(parted) set 1 bios_grub on`

    * Create a Boot partition
       * `(parted) mkpart primary fat32 3 515`
       * `(parted) name 2 boot`
       * `(parted) set 2 BOOT on` 

    * Use the rest of the disk for lvm
       * `(parted) mkpart primary 515 -1`
       * `(parted) name 3 lvm`
       * `(parted) set 3 lvm on`

    * Exit parted
       * `(parted) quit`

    * FAT32 format the boot parition
       * `mkfs.vfat -F32 /dev/sdn2`

2. Setup LVM
    * `cryptsetup -v -y -c aes-xts-plain64 -s 512 -h sha512 -i 5000 --use-random luksFormat /dev/sdn3`
    * `cryptsetup luksDump /dev/sdn3`
    * `cryptsetup luksOpen /dev/sdn3 lvm`
    * `lvm pvcreate /dev/mapper/lvm`
    * `vgcreate vg0 /dev/mapper/lvm`
    * `lvcreate -C y -L 8G vg0 -n swap`
    * `lvcreate -l +100%FREE vg0 -n root`
    * `vgscan`
    * `vgchange -ay`
    * `mkswap /dev/mapper/vg0-swap`
    * `swapon /dev/mapper/vg0-swap`
    * `mkfs.ext4 /dev/mapper/vg0-root`

3. Install Base System (Stage 3 tarball)
    * `mkdir /mnt/gentoo`
    * `mount /dev/mapper/vg0-root /mnt/gentoo`
    * `cd /mnt/gentoo`
    * `wget https://gentoo.osuosl.org/releases/amd64/autobuilds/current-stage3-amd64/stage3-amd64-20181225T214502Z.tar.xz`
    * `tar xvjpf current-stage3-*.tar.xz --xattrs --numeric-owner` 

4. Configure Portage
    * `mkdir /mnt/gentoo/etc/portage/repos.conf`
    * `cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf`

5. Chroot into system
    * `cp /etc/resolv.conf /mnt/gentoo/etc/resolv.conf`
    * `mount -t proc /proc /mnt/gentoo/proc`
    * `mount --rbind /sys /mnt/gentoo/sys`
    * `mount --make-rslave /mnt/gentoo/sys`
    * `mount --rbind /dev /mnt/gentoo/dev`
    * `mount --make-rslave /mnt/gentoo/dev`
    * `chroot /mnt/gentoo /bin/bash`
    * `source /etc/profile`

6. Setup the system
    * `mount /dev/sdn2 /boot`
    * `emerge --sync`
    * `emerge-webrsync`
    * `eselect profile list`
    * `eselect profile set X`
    * `echo America/New_York > /etc/timezone`
    * `emerge --config sys-libs/timezone-data`
    * `nano -w /etc/locale.gen`
    * `locale-gen`
    * `eselect locale list`
    * `eselect locale set 1`
    * `env-update && source /etc/profile`

7. Configure /etc/fstab
```
# <fs>			        <mountpoint>	<type>		<opts>		    <dump/pass>
/dev/sdn2		        /boot		    vfat		noauto,noatime	1 2
/dev/mapper/vg0-root	/		        ext4		noatime		    0 1
/dev/mapper/vg0-swap	none		    swap		defaults	    0 0
```
8. Compile the Kernel
    * This is highly machine dependent. I recommned following the official docs
        * [https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Kernel](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Kernel)
        * Make sure to add the configuration options for LVM and dm-crypt
            * [https://wiki.gentoo.org/wiki/LVM](https://wiki.gentoo.org/wiki/LVM)
            * [https://wiki.gentoo.org/wiki/Dm-crypt](https://wiki.gentoo.org/wiki/Dm-crypt)

9. Install GRUB
    * `echo "sys-boot/grub:2 device-mapper" >> /etc/portage/package.use/sys-boot`
    * `emerge -av grub`
    * `nano -w vim /etc/default/grub`
        * `GRUB_CMDLINE_LINUX="dolvm crypt_root=/dev/sdn3 real_root=/dev/mapper/vg0-root rootfstype=ext4 root_trim=yes quiet"`
    * `mount /boot`
    * `grub-install --target=x86_64-efi --efi-directory=/boot`
    * If the above command fails, run this and re-run it
        * `mount -o remount,rw /sys/firmware/efi/efivars`

10. Finalizing
    * `useradd -m -G users,wheel,audio -s /bin/bash username`
    * `passwd username`
    * `rm /current-stage3-*.tar.bz2*`
    * `rc-update add lvm default`
    *  [See here for more](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Finalizing)
