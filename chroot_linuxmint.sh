#!/bin/bash

# Autochroot für Linux Mint.
# /dev/sda1 muss geändert werden für die / partition
# je nachdem muss man evtl noch die EFI partition (/boot/efi) und sofern separat vorhanden die /home partition. 

# Bsp: (root) sudo mount /dev/sda2 /mnt    (efi) sudo mount /dev/sda1 /mnt/boot/efi


sudo mount /dev/sda1 /mnt
for i in /dev /dev/pts /proc /sys /run; do sudo mount -B $i /mnt$i; done

sudo chroot /mnt /bin/bash -i
