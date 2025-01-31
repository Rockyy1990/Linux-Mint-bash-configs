#!/usr/bin/env bash

echo ""
read -p "LinuxMint Postinstall Script. Press any key to continue..!"
clear

sudo dpkg --add-architecture i386

sudo apt autoremove -y celluloid rhythmbox

sudo apt update -y

sudo mkdir -pm755 /etc/apt/keyrings
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key -

sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/noble/winehq-noble.sources

sudo add-apt-repository ppa:oibaf/graphics-drivers


wget -qO - https://dl.xanmod.org/archive.key | sudo gpg --dearmor -vo /etc/apt/keyrings/xanmod-archive-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/xanmod-archive-keyring.gpg] http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-release.list


sudo apt update
sudo apt install --install-recommends winehq-staging
sudo apt install -y linux-xanmod-x64v3


sudo apt install -y steam lame flac strawberry synaptic libgdiplus protontricks wayland-protocols libfaudio0 
sudo apt install -y easyeffects pipewire-v4l2 pipewire-libcamera vlc-plugin-pipewire
sudo apt install -y soundconverter
 
sudo wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp
sudo chmod a+rx /usr/local/bin/yt-dlp

sudo apt upgrade -y
sudo apt dist-upgrade -y


flatpak update
flatpak install flathub com.github.tchx84.Flatseal
flatpak install flathub com.discordapp.Discord
flatpak install flathub net.davidotek.pupgui2
flatpak install flathub ru.linux_gaming.PortProton



sudo systemctl enable fstrim.timer
sudo fstrim -av
sudo apt autoclean
sudo apt purge

sudo reboot


