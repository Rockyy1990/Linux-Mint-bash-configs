#!/usr/bin/env bash

echo ""
echo ""
echo "----------------------------------------------"
echo "     ..Linux Mint config after install..      "
echo "                                              "
echo "----------------------------------------------"
sleep 1

echo ""
echo "The following programs will be installed:"
echo "1. WineHQ Staging"
echo "2. Linux Xanmod Kernel"
echo "3. System Packages: f2fs-tools, xfsdump, samba, curl, vulkan-tools, libfsntfs1t64, git, mintupgrade"
echo "4. Windows Imaging Tools: wimtools, winregfs, boot-repair, os-uninstaller"
echo "5. Multimedia Codecs: ffmpeg, lame, flac, x264, x265, sox, libsox-fmt-mp3, libsox-fmt-ao, vpx-tools, speex"
echo "6. Various Programs: file-roller, winff, vlc, strawberry, transmission, yt-dlp"
echo "7. Steam Gaming Platform: steam, wine-binfmt, libwinpr3-3, libfaudio0, libgdiplus, protontricks, proton-caller, libvkd3d1, libvkd3d-shader1, goverlay"
echo ""
echo "The following configurations will be made:"
echo "1. Add i386 architecture support"
echo "2. Add various PPAs for graphics drivers, apps, Pipewire, and WirePlumber"
echo "3. Set up the Xanmod kernel repository"
echo "4. Enable fstrim.timer for SSD maintenance"
echo "5. Create a Timeshift backup"
sleep 2
echo ""
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


# Install system packages
sudo apt install -y f2fs-tools xfsdump samba curl vulkan-tools libfsntfs1t64 git mintupgrade 
sudo apt install -y synaptic gnome-firmware wayland-protocols gsmartcontrol fakeroot winbind libnss-winbind 

# Windows imaging tools
sudo apt install -y wimtools winregfs boot-repair os-uninstaller

# Installs Multimedia Codes
sudo apt install -y ffmpeg lame flac x264 x265 sox libsox-fmt-mp3 libsox-fmt-ao vpx-tools speex
sudo apt install -y easyeffects pavucontrol pipewire-v4l2 pipewire-libcamera vlc-plugin-pipewire pipewire-vulkan

# Install various Programs
sudo apt install -y file-roller winff vlc strawberry transmission yt-dlp

# Install Steam Gaming Platform 
sudo apt install -y steam wine-binfmt libwinpr3-3 libfaudio0 libgdiplus protontricks proton-caller libvkd3d1 libvkd3d-shader1 goverlay



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
flatpak install flathub com.usebottles.bottles
flatpak install flathub org.strawberrymusicplayer.strawberry





sudo timeshift --create

sudo reboot
