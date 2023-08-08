#!/usr/bin/env bash

# Linux Mint Cinnamon

echo ""
echo "Dieses Script ist für eine Partitionierung und Installation mit ext4 auf / (root) gedacht."
echo "/home kann separat xfs oder ext4 sein. Ext4 ist besser für Steam"
echo "Es wird das apt frontend nala verwendet anstelle von apt."
echo "nala update , nala upgrade, nala install -y etc.."
echo "Zudem wird ein für Gaming und Multimedia optimierter Kernel installiert (Xanmod)."
echo ""
echo "Für yt-dlp wird pip3 verwendet. Mit (python -m pip3 install --upgrade pip) kann pip aktualisiert werden."
echo ""
echo "Führen sie dieses Script nicht aus wenn sie nicht wissen was sie tun"


#Set text color to red
RED='\033[0;31m'
NC='\033[0m'


echo ""
echo "Press any key to start the script..."
read -n 1 -s
echo -e "${RED}Starting the script..${NC}"
sleep 3
clear

echo ""
echo -e "${RED}-----------------------------------------------------------${NC}"
echo -e "${RED}Linux Mint postconfig after install${NC}"
echo -e "${RED}You may need to reboot the system after running this script${NC}"
echo -e "${RED}-----------------------------------------------------------${NC}"
echo ""
sleep 5
clear

echo ""
echo "Remove mintinstall"
echo "The Linux Mint Package Store"
echo ""
sleep 3
sudo dpkg -r --force-depends mintinstall
sudo apt-mark hold mintinstall
sudo apt --fix-broken install -y
clear

sudo dpkg --add-architecture i386

echo ""
echo "Installing and using nala instead of apt"
echo ""
sleep 3

sudo apt update
sudo apt install -y nala
echo ""
echo "Installation of nala is complete"
sleep 3
clear


echo "Remove unneeded packages"
echo ""
sleep 2
sudo nala purge -y hexchat transmission-gtk pix pix-data onboard rhythmbox rhythmbox-data celluloid redshift xviewer xviewer-plugins orca transmission-common
sudo nala purge -y zfs-zed zfsutils-linux libzfs4linux xed 
clear


echo "Installing usefull packages.."
echo ""
sleep 3
sudo nala install -y build-essential zenity gparted fakeroot ttf-mscorefonts-installer winbind gsmartcontrol 7zip preload needrestart
sudo nala install -y vlc qbittorrent eog eog-plugins f2fs-tools xfsdump brasero brasero-cdrkit gnome-text-editor
clear


echo ""
echo "Install and config nvidia driver"
echo ""
sleep 3
sudo add-apt-repository ppa:graphics-drivers/ppa -y && sudo apt update
sudo apt install -y nvidia-driver-525 nvidia-settings libxnvctrl0 vdpauinfo
sudo chmod u+x /usr/share/screen-resolution-extra/nvidia-polkit
echo ""
echo ""

#echo "Configure nvidia.."
#echo ""
#sleep 3
#sudo nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0 +0 { ForceFullCompositionPipeline = On }"
#sudo nvidia-settings --assign GPUPowerMizerMode=1
#sudo nvidia-settings --load-config-only
#echo ""
#echo "Nvidia config is complete"
#sleep 3
clear

echo ""
echo "Install Multimedia Codecs"
echo ""
sleep 3
sudo nala install -y ubuntu-restricted-extras lame flac x264 libavcodec-extra libfdk-aac2 wavpack libmad0
sudo nala install -y winff ffmpeg  libsox-fmt-all
clear

echo ""
echo "Youtube downloader (yt-dlp)"
echo ""
sleep 3
sudo wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp
sudo chmod a+rx /usr/local/bin/yt-dlp
clear

echo "Download and Install Steam Gaming Platform"
echo ""
sleep 3
wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb
sudo gdebi --non-interactive steam.deb
echo ""
sudo nala install -y gamemode libxtst6:i386 libudev-dev libfaudio0 libvulkan1:i386 libvulkan1 libopenal1 libvkd3d1 libc6:amd64 libc6:i386 libegl1:amd64 libegl1:i386
sudo nala install -y  libgbm1:amd64 libgbm1:i386 libgl1-mesa-dri:amd64 libgl1-mesa-dri:i386 libgl1:amd64 libgl1:i386 steam-libs-amd64:amd64 steam-libs-i386:i386
clear

echo ""
echo "Install latest wine-staging"
echo ""
sleep 3
sudo dpkg --add-architecture i386
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ jammy main'
sudo nala update
sudo apt install --install-recommends -y winehq-staging
clear

echo ""
echo "Download and install Dopamine 3.0 Music Player"
echo ""
sleep 3
wget https://github.com/digimezzo/dopamine/releases/download/v3.0.0-preview19/Dopamine-3.0.0-preview.19.deb
sudo gdebi --non-interactive Dopamine-3.0.0-preview.19.deb
clear

echo ""
echo "Install and config pipewire"
echo ""
sleep 3
sudo add-apt-repository ppa:pipewire-debian/pipewire-upstream
sudo nala update 
sudo nala install -y pipewire pipewire-pulse wireplumber pavucontrol pulseaudio-utils libspa-0.2-bluetooth
sudo systemctl restart pipewire
clear

# Configure Pipewire
sudo sed -i 's/; default-fragments = 4/default-fragments = 2/g' /etc/pipewire/pipewire.conf
sudo sed -i 's/; default-fragment-size-msec = 25/default-fragment-size-msec = 10/g' /etc/pipewire/pipewire.conf
clear

echo ""
echo "Install Xanmod Kernel"
echo "You need to check the cpu for choose the right xanmod kernel version"
echo ""
sleep 4
wget -qO - https://dl.xanmod.org/archive.key | sudo gpg --dearmor -o /usr/share/keyrings/xanmod-archive-keyring.gpg
echo 'deb [signed-by=/usr/share/keyrings/xanmod-archive-keyring.gpg] http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-release.list
sudo nala update
sudo nala install -y linux-xanmod-x64v3
clear


echo ""
echo "Flatpak PPA"
echo ""
sleep 3
sudo add-apt-repository ppa:flatpak/stable
clear

echo ""
echo "System upgrade and cleaning"
echo ""
sleep 4
sudo nala update
sudo nala upgrade -y
sudo apt dist-upgrade -y
clear

sudo nala clean

# Remove old kernels
sudo apt autoremove --purge -y

# Clean up temporary files
sudo rm -rf /tmp/*

# Clean up log files
sudo find /var/log -type f -exec sudo truncate -s 0 {} \;
clear


echo ""
echo "Configure Cinnamon Desktop"
echo ""
sleep 3

##########################################################################

# Configure Icon theme and System theme
gsettings set org.cinnamon.desktop.interface icon-theme 'Mint-L'
gsettings set org.cinnamon.theme name 'Mint-L'
gsettings set org.cinnamon.desktop.interface gtk-theme 'Mint-L'
gsettings set org.cinnamon.desktop.wm.preferences theme 'Mint-L'


# Disable the screensaver and screen idle timers
gsettings set org.cinnamon.desktop.screensaver lock-enabled false
gsettings set org.cinnamon.desktop.session idle-delay 0

# Remove the "Recent" files from the Cinnamon menu
gsettings set org.cinnamon.desktop.privacy remember-recent-files false

# Enable natural scrolling
gsettings set org.cinnamon.settings-daemon.peripherals.mouse natural-scroll true

# Disable window tiling on drag
gsettings set org.cinnamon.muffin.drag-to-maximize false

#Enable graphical effects on menus and tooltips:
gsettings set org.cinnamon.desktop.interface menus-have-icons true

# Enable window buttons on the left side
gsettings set org.cinnamon.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

# Configure the default terminal emulator (change 'gnome-terminal' to your preferred terminal)
gsettings set org.cinnamon.desktop.default-applications.terminal exec 'gnome-terminal'

# Change the default file manager (change 'nemo' to your preferred file manager)
gsettings set org.cinnamon.desktop.default-applications.terminal exec 'nemo'

# Set the wallpaper (change '/path/to/your/wallpaper.jpg' to the desired wallpaper location)
#gsettings set org.cinnamon.desktop.background picture-uri 'file:///path/to/your/wallpaper.jpg'

# Restart Cinnamon for the changes to take effect
cinnamon --replace &

##################################################################################

echo ""
echo "Cinnamon config complete"
sleep 3
clear

echo ""
echo "Install and config Z-Shell"
echo ""
sleep 3
sudo nala install -y zsh zsh-autosuggestions zsh-syntax-highlighting zgen
sudo nala install -y zsh-theme-powerlevel9k fonts-powerline fizsh

# Ändere die Standard-Shell zu zsh
chsh -s "$(command -v fizsh)"
sudo echo 'exec fizsh' >> ~/.bashrc

echo ""
echo ""
echo "Z-Shell install and config complete."
sleep 3
clear

echo ""
echo "Update Flatpak and install some stuff"
echo ""
sleep 3
flatpak update
clear

echo "Discord"
echo ""
flatpak install -y flathub com.discordapp.Discord
clear
echo "Protonup-Qt"
echo ""
flatpak install -y flathub net.davidotek.pupgui2
clear
echo "Bottles (wine bottles managing)"
echo ""
flatpak install -y flathub com.usebottles.bottles
clear

echo "Gnome-Boxes (Virtualisierung)"
echo ""
flatpak install -y flathub org.gnome.Boxes
clear
echo "Freac Audio/Video Converter"
echo ""
flatpak install -y flathub org.freac.freac
clear
echo ""

sudo ufw enable
sudo fstrim -av
sudo systemctl enable fstrim.timer
sudo fwupdmgr update

sudo nala history clear --all

clear
echo ""
echo -e "${RED}Linux Mint config is complete. You may need to reboot for use the xanmod Kernel.${NC}"
echo -e "${RED}Have fun!${NC}"
sleep 2
echo ""
exit
