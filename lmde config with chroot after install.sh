#!/usr/bin/env bash

echo "LMDE config after install"
echo "chroot LMDE LIVE System after install" 
sleep 4

sudo mount /dev/sda2 /mnt 
sudo mount /dev/sda1 /mnt/boot 
for dir in /dev /dev/pts /proc /sys /run; do sudo mount --bind $dir /mnt$dir; done 
sudo mount -o bind /etc/resolv.conf /mnt/etc/resolv.conf   
sudo chroot /mnt /bin/bash
clear

echo "Mirrors update & System upgrade"
sleep 3
sudo apt-get update
sudo apt autoremove -y hexchat redshift xed celluloid rhythmbox
sudo apt-get dist-upgrade -y


sudo apt install -y gedit gedit-plugins shotwell ntpdate libvulkan1 libvulkan1:i386 pavucontrol xfsdump f2fs-tools lame flac libsox3 sox vlc gnome-disk-utility cpufreqd 
clear

sudo bash -c "echo neofetch" >> /etc/bashrc

flatpak install strawberry discord freac

echo "SSD Trim einrichten"
sudo systemctl enable --now fstrim.timer 

clear

echo "Install Intel Graphics Driver.."
sleep 2
sudo apt install  i965-va-driver-shaders intel-media-va-driver-non-free intel-opencl-icd mesa-opencl-icd mesa-vulkan-drivers mesa-vdpau-drivers libosmesa6 libvkd3d1 libopengl0 libopenlayer2v5 libvdpau-va-gl1 libva-glx2

sudo apt autoremove -y
sudo apt autoclean -y
sudo fstrim  -av

echo "verlassen von chroot"
sleep 6

reboot


