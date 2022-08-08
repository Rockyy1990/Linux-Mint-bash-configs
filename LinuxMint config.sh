#!/usr/bin/env bash

echo "----------------------------------------------------"
echo "Linux Mint configuration.."
echo ""
echo "Unnötige Pakete entfernen plus nützliche hinzufügen"
echo "----------------------------------------------------"
sleep 4
clear

echo "System update & upgrade"
sudo apt autoremove -y hexchat redshift celluloid rhythmbox
sudo dpkg --add-architecture i386  
sudo apt update  
sudo apt dist-upgrade -y
clear

sudo apt install -y gnome-text-editor ntpdate libvulkan1 libvulkan1:i386 pavucontrol apulse build-essential plymouth-x11 mint-meta-codecs libfaac0 libfaudio0 x265 h264enc x264 vlc audacity flac alac-decoder gnome-disk-utility ubuntu-restricted-extras gsmartcontrol preload libgdiplus indicator-cpufreq cpufrequtils dkms hardinfo bleachbit yt-dlp neofetch 
sudo ufw enable

sudo bash -c "echo neofetch >> /etc/bashrc"

echo "Sox Audio Processing"
sudo apt install -y sox libsoxr0 libsox3 libsox-fmt-base libsox-fmt-pulse libsox-fmt-mp3 libsox-fmt-ao
clear
echo "Strawberry Player"
sudo add-apt-repository ppa:jonaski/strawberry 
sudo apt-get update -y 
sudo apt-get install -y strawberry
clear
echo "OpenGL Graphics Driver"
sleep 2
sudo add-apt-repository ppa:oibaf/graphics-drivers 
sudo apt-get update 
sudo apt upgrade -y
clear
echo ""
echo "Install Nvidia Graphics Driver"
sleep 2
sudo add-apt-repository ppa:graphics-drivers/ppa   
sudo apt update
sudo apt install -y nvidia-dkms-515 nvidia-driver-515 nvidia-settings libnvidia-gl-515 libnvidia-gl-515:i386 nvidia-compute-utils-515 nvidia-utils-515 build-essential
clear
echo ""
echo "Steam Gaming Platform"
sleep 2
sudo apt-get install --install-recommends steam-installer steam:i386 steam-devices 
clear
echo ""
echo "Flatpakt Repository für die neueste Version"
sudo add-apt-repository ppa:alexlarsson/flatpak 
sudo apt update 
sudo apt upgrade -y
flatpak install discord freac
clear
echo ""
echo "XanMod Kernel (optimierte Kernel)"
sleep 3
echo 'deb http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-kernel.list
wget -qO - https://dl.xanmod.org/gpg.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/xanmod-kernel.gpg add -
sudo apt update  
sudo apt install linux-xanmod
clear

echo "SSD Trim"
sudo systemctl enable --now fstrim.timer 
sudo fstrim  -av

echo "Abschluss und reboot"
sleep 3
sudo apt-get autoremove -y  
sudo apt-get autoclean -y
sudo apt-get clean -y
sudo rm -rfv /var/tmp/flatpak-cache-*
flatpak uninstall --delete-data -y
sudo update-grub
clear
echo ""
echo "Linux Mint wurde konfiguriert.. jetzt wird aufgeräumt"
echo ""
history -c

exit 0

