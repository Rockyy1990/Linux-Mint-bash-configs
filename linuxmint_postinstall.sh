#!/usr/bin/env bash

echo ""
echo ""
echo "----------------------------------------------"
echo "     ..Linux Mint config after install..      "
echo "                                              "
echo "----------------------------------------------"
sleep 1

read -p "Read this script before execute!!"
clear

sudo dpkg --add-architecture i386

sudo apt autoremove -y celluloid rhythmbox

sudo apt update -y

sudo mkdir -pm755 /etc/apt/keyrings
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key -

sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/noble/winehq-noble.sources



# Up to date graphics driver
sudo add-apt-repository ppa:oibaf/graphics-drivers

# Extra up to date Apps
sudo add-apt-repository -y ppa:xtradeb/apps

# Latest Pipewire
sudo add-apt-repository -y ppa:pipewire-debian/pipewire-upstream

# Latest WirePlumber
sudo add-apt-repository -y ppa:pipewire-debian/wireplumber-upstream


# Xanmod Kernel
wget -qO - https://dl.xanmod.org/archive.key | sudo gpg --dearmor -vo /etc/apt/keyrings/xanmod-archive-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/xanmod-archive-keyring.gpg] http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-release.list



sudo apt update

sudo apt install --install-recommends winehq-staging
sudo apt install -y linux-xanmod-x64v3


sudo apt install -y file-roller f2fs-tools xfsdump samba curl
sudo apt install -y synaptic wayland-protocols gsmartcontrol fakeroot winbind  
sudo apt install -y ffmpeg lame flac x264 x265 sox libsox-fmt-mp3 libsox-fmt-ao 
sudo apt install -y easyeffects pavucontrol pipewire-v4l2 pipewire-libcamera vlc-plugin-pipewire
sudo apt install -y soundconverter vlc strawberry transmission yt-dlp
sudo apt install -y steam libfaudio0 libgdiplus protontricks

sudo apt upgrade -y
sudo apt dist-upgrade -y

sudo apt autoremove -y
sudo apt autoclean -y
sudo apt clean

sudo systemctl enable fstrim.timer
sudo fstrim -av


flatpak update
flatpak install flathub com.github.tchx84.Flatseal
flatpak install flathub com.discordapp.Discord
flatpak install flathub net.davidotek.pupgui2
flatpak install flathub ru.linux_gaming.PortProton

sudo timeshift --create

sudo reboot


