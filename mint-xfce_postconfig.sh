#!/usr/bin/env bash

# Linux Mint Xfce
# Last Edit: 11.08.2023 13:40

# Orange color escape code
ORANGE='\033[0;33m'
# Reset color escape code
NC='\033[0m'

# Echo command with orange color
#echo -e "${ORANGE}This is an orange message.${NC}"


echo ""
echo "Dieses Script ist für eine Partitionierung und Installation mit ext4 auf / (root) gedacht."
echo "/home kann separat xfs oder ext4 sein. Ext4 ist besser für Steam."
echo "Es wird das apt frontend nala verwendet anstelle von apt."
echo "nala update , nala upgrade, nala install -y etc.."
echo ""
echo " Die installation von Steam und dem Xanmod Kernel sind optional."
echo "Möglichkeit zur installation einer Z-Shell."
echo "Möglichkeit zur Einrichtung von Pipewire. (Pulseaudio alternative)"
echo ""
echo -e "${ORANGE}Führen sie dieses Skript nur dann aus wenn sie wissen was sie tun!${NC}"

echo ""
echo "Press any key to start the script..."
read -n 1 -s
echo -e "${ORANGE}Starting the script...${NC}"
sleep 3
clear

# Change to Cloudflare DNS
# Backup the existing DNS configuration
sudo cp /etc/resolv.conf /etc/resolv.conf.bak

# Create a new resolv.conf file
echo "nameserver 1.1.1.1" | sudo tee /etc/resolv.conf 
echo "nameserver 1.0.0.1" | sudo tee -a /etc/resolv.conf 

# Restart the network manager service to apply the changes
sudo systemctl restart NetworkManager
sleep 3
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

# Adding 32bit Package support
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
sudo nala purge -y hexchat pix pix-data onboard rhythmbox rhythmbox-data celluloid redshift xviewer xviewer-plugins orca transmission-common transmission-gtk
sudo nala purge -y zfs-zed zfsutils-linux libzfs4linux xed warpinator webapp-manager
echo ""
echo "Remove xfce packages"
sleep 2
sudo nala purge -y atril* parole* xarchiver* xsane* xterm* seahorse* simple-scan* xfce4-dict* drawing*
clear


echo "Installing usefull packages.."
echo ""
sleep 3
sudo nala install -y build-essential zenity gparted fakeroot gdebi neofetch
sudo nala install -y winbind needrestart gsmartcontrol 7zip preload pavucontrol
sudo nala install -y vlc qbittorrent eog eog-plugins f2fs-tools xfsdump brasero brasero-cdrkit gnome-text-editor

sudo echo 'neofetch' >> ~/.bashrc

#MS Fonts with automatic set eula to true
sudo debconf-set-selections << EOF
ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true

sudo apt install ttf-mscorefonts-installer -y
sudo fc-cache -f -v
EOF
clear

# Prompt user for input
read -p "Do you want to install Xanmod Kernel? (y/n): " answer

# Check user's response
if [ "$answer" = "y" ]; then
    echo "Installing Xanmod Kernel ..."
    # Add commands here to Install Xanmod Kernel
    wget -qO - https://dl.xanmod.org/archive.key | sudo gpg --dearmor -o /usr/share/keyrings/xanmod-archive-keyring.gpg
echo 'deb [signed-by=/usr/share/keyrings/xanmod-archive-keyring.gpg] http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-release.list
sudo nala update
sudo nala install -y linux-xanmod-x64v3
sudo nala install -y linux-xanmod-lts-x64v3

    echo "Xanmod Kernel installation complete."

elif [ "$answer" = "n" ]; then
    echo "Skipping Xanmod Kernel installation."

else
    echo "Invalid response. Please enter either 'y' or 'n'."

fi


echo ""
echo "Install and config nvidia driver"
echo ""
sleep 2
sudo add-apt-repository ppa:graphics-drivers/ppa -y  
sudo apt update
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
sudo nala install -y winff ffmpeg libsox-fmt-all
clear

echo ""
echo "Youtube downloader (yt-dlp)"
echo ""
sleep 3
sudo wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp
sudo chmod a+rx /usr/local/bin/yt-dlp
clear



# Prompt user for input
read -p "Do you want to install Steam with all libraries? (y/n): " answer

# Check user's response
if [ "$answer" = "y" ]; then
    echo "Installing Steam with all libraries..."
    # Add commands here to install Steam with all libraries
    wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb
sudo gdebi --non-interactive steam.deb
sudo nala install -y gamemode libxtst6:i386 libudev-dev libfaudio0 libvulkan1:i386 libvulkan1 libopenal1 libvkd3d1 libc6:amd64 libc6:i386 libegl1:amd64 libegl1:i386
sudo nala install -y libgbm1:amd64 libgbm1:i386 libgl1-mesa-dri:amd64 libgl1-mesa-dri:i386 libgl1:amd64 libgl1:i386 steam-libs-amd64:amd64 steam-libs-i386:i386

    echo "Steam installation with all libraries complete."

elif [ "$answer" = "n" ]; then
    echo "Skipping Steam installation."

else
    echo "Invalid response. Please enter either 'y' or 'n'."

fi
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
echo "You may look for a newer version and update the download link befor use the script."
sleep 3
wget https://github.com/digimezzo/dopamine/releases/download/v3.0.0-preview19/Dopamine-3.0.0-preview.19.deb
sudo gdebi --non-interactive Dopamine-3.0.0-preview.19.deb
clear


# Prompt user for input
read -p "Do you want to install Pipewire? (y/n): " answer

# Check user's response
if [ "$answer" = "y" ]; then
    echo "Installing Pipewire with all libraries..."
    # Add commands here to install Steam with all libraries
  sudo add-apt-repository ppa:pipewire-debian/pipewire-upstream -y
sudo nala update 
sudo nala install -y pipewire pipewire-pulse wireplumber pulseaudio-utils libspa-0.2-bluetooth pipewire-v4l2


# Backup the original pipewire.conf file
cp /etc/pipewire/pipewire.conf /etc/pipewire/pipewire.conf.bak

# Configure Pipewire
sudo sed -i 's/; default-fragments = 4/default-fragments = 2/g' /etc/pipewire/pipewire.conf
sudo sed -i 's/; default-fragment-size-msec = 25/default-fragment-size-msec = 10/g' /etc/pipewire/pipewire.conf  
sudo sed -i 's/; default.clock.rate = 48000/default.clock.rate = 96000/g' /etc/pipewire/pipewire.conf  
sudo systemctl restart pipewire

   
   echo "Pipewire installation with all libraries complete."

elif [ "$answer" = "n" ]; then
    echo "Skipping Pipewire installation."

else
    echo "Invalid response. Please enter either 'y' or 'n'."

fi
clear


echo ""
echo "Flatpak PPA"
echo ""
sleep 3
sudo add-apt-repository ppa:flatpak/stable -y
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
sudo apt autoclean -y

# Clean up temporary files
sudo rm -rf /tmp/*

# Clean up log files
sudo find /var/log -type f -exec sudo truncate -s 0 {} \;
clear



# Z-Shell install abfrage
read -p "Do you want to install Z-Shell? (y/n): " answer

# Check user's response
if [ "$answer" = "y" ]; then
    echo "Installing Z Shell ..."
    # Add commands here to install Steam with all libraries
sudo nala install -y zsh zsh-autosuggestions zsh-syntax-highlighting zgen
sudo nala install -y zsh-theme-powerlevel9k fonts-powerline fizsh
chsh -s "$(command -v fizsh)"
sudo echo 'exec fizsh' >> ~/.bashrc
    echo "Z-Shell installation complete."

elif [ "$answer" = "n" ]; then
    echo "Skipping Z-Shell installation."

else
    echo "Invalid response. Please enter either 'y' or 'n'."

fi

clear

echo ""
echo "Config XFCE Icon Theme and Style..."
sleep 3
###################################################################################

#icons:
xfconf-query -c xsettings -p /Net/IconThemeName -s Mint-L

#theme:
xfconf-query -c xsettings -p /Net/ThemeName -s Mint-L
xfconf-query -c xfwm4 -p /general/theme -s Mint-L-Dark


###################################################################################
echo ""
echo "XFCE config is complete"
sleep 2
clear

echo ""
echo "Update Flatpak and install some stuff"
echo ""
sleep 2
flatpak update
sleep 1

echo ""
echo ""
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
echo ""
sudo fstrim -av
sudo systemctl enable fstrim.timer
sudo fwupdmgr update

sudo nala history clear --all

clear
echo ""
echo -e "${ORANGE}Linux Mint config is complete. You may need to reboot for use the xanmod Kernel.${NC}"
echo -e "${ORANGE}Have fun!${NC}"
sleep 2

read -p "Do you wont to restart the Linux Mint? (y/n): " option

if [ "$option" == "y" ]; then
  sudo reboot
elif [ "$option" == "n" ]; then
  exit
fi
