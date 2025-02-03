#!/usr/bin/env bash

echo ""
echo "----------------------------------------------"
echo "     ..Linux Mint config after install..      "
echo "              Cinnamon Desktop                "
echo "----------------------------------------------"
sleep 1

echo ""
echo "The following programs will be installed:"
echo "1. WineHQ Staging"
echo "2. Linux Xanmod Kernel"
echo "3. System Packages: f2fs-tools, xfsdump, samba, curl, vulkan-tools, libfsntfs1t64, git, mintupgrade, fastfetch"
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
echo "5. Set /etc/environment variables"
echo "6. Enable and config ufw firewall"
echo "7. Cinnamon Settings"
echo "8. Create a Timeshift backup"
sleep 2
echo ""
read -p "Read this script before execute!!"
clear

echo ""
echo -e " Remove unneeded packages.."
sleep 2

sudo apt autoremove -y firefox celluloid rhythmbox hypnotix redshift pix pix-data transmission-gtk zfs-zed zfsutils-linux libzfs4linux 
sudo apt remove --purge -y libreoffice*
echo ""

echo "Remove mintinstall"
echo "The Linux Mint Package Store"
sleep 2
sudo dpkg -r --force-depends mintinstall
sudo apt-mark hold mintinstall
sudo apt --fix-broken install -y
clear

sudo apt update -y

sudo dpkg --add-architecture i386

echo ""
echo -e "Adding some Software PPAs.."
sleep 2

sudo mkdir -pm755 /etc/apt/keyrings
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key -

sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/noble/winehq-noble.sources


echo -e "Up to date graphics driver"
sleep 1
sudo add-apt-repository -y ppa:oibaf/graphics-drivers
clear

echo -e "Extra up to date Apps"
sleep 1
sudo add-apt-repository -y ppa:xtradeb/apps
clear

echo -e "Latest Pipewire"
sleep 1
sudo add-apt-repository -y ppa:pipewire-debian/pipewire-upstream
clear

echo -e "Latest WirePlumber"
sleep 1
sudo add-apt-repository -y ppa:pipewire-debian/wireplumber-upstream
clear

echo -e "Fastfetch"
sleep 1
sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
clear


echo -e "Xanmod Kernel"
sleep 1
wget -qO - https://dl.xanmod.org/archive.key | sudo gpg --dearmor -vo /etc/apt/keyrings/xanmod-archive-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/xanmod-archive-keyring.gpg] http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-release.list

sudo apt update
clear

sudo apt install --install-recommends winehq-staging
clear

sudo apt install -y linux-xanmod-x64v3
clear


echo -e "Install system packages"
sleep 2
sudo apt install -y build-essential f2fs-tools xfsdump samba curl vulkan-tools libfsntfs1t64 git mintupgrade zenity 
sudo apt install -y synaptic gnome-firmware wayland-protocols gsmartcontrol fakeroot winbind libnss-winbind ttf-mscorefonts-installer

echo "fastfetch" | sudo tee -a ~/.bashrc


echo -e "Windows imaging tools"
sleep 2
sudo apt install -y wimtools winregfs boot-repair 
clear

echo -e "Installs Multimedia Codes"
sleep 2
sudo apt install -y ffmpeg lame flac x264 x265 sox libsox-fmt-mp3 libsox-fmt-ao vpx-tools speex
sudo apt install -y easyeffects pavucontrol pipewire-v4l2 pipewire-libcamera pipewire-vulkan
clear

echo -e "Install various Programs"
sleep 2
sudo apt install -y file-roller soundconverter yt-dlp eog eog-plugins
clear

echo -e "Install Steam Gaming Platform" 
sleep 2
sudo apt install -y steam wine-binfmt libwinpr3-3 libfaudio0 libgdiplus protontricks proton-caller libvkd3d1 libvkd3d-shader1 goverlay
clear


echo ""
echo -e "Install some flatpaks.."
sleep 2
echo ""

flatpak update
flatpak install -y flathub com.github.tchx84.Flatseal
flatpak install flathub io.github.giantpinkrobots.flatsweep
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub net.davidotek.pupgui2
flatpak install -y flathub com.usebottles.bottles
flatpak install -y flathub org.libreoffice.LibreOffice
flatpak install -y flathub org.strawberrymusicplayer.strawberry
flatpak install -y flathub net.waterfox.waterfox
flatpak install -y flathub io.github.giantpinkrobots.varia
flatpak install -y flathub io.github.celluloid_player.Celluloid
clear

echo ""
echo -e "Linux Mint System update.."
sleep 2
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo update-grub
clear


# Remove old kernels
sudo apt autoremove --purge -y
sudo apt clean

# Clean up temporary files
sudo rm -rf /tmp/*

# Clean up log files
sudo find /var/log -type f -exec sudo truncate -s 0 {} \;
clear

sudo systemctl enable fstrim.timer
sudo fstrim -av
clear

echo ""
echo -e "Set environment variables "
echo ""
sleep 1
    echo -e "
   CPU_LIMIT=0
   CPU_GOVERNOR=performance
   GPU_USE_SYNC_OBJECTS=1
   SHARED_MEMORY=1
   PYTHONOPTIMIZE=1
   ELEVATOR=noop
   TRANSPARENT_HUGEPAGES=always
   MALLOC_CONF=background_thread:true
   MALLOC_CHECK=0
   MALLOC_TRACE=0
   LD_DEBUG_OUTPUT=0
   AMD_VULKAN_ICD=RADV
   RADV_PERFTEST=aco,sam,nggc
   RADV_DEBUG=novrsflatshading
   STEAM_RUNTIME_HEAVY=1
   STEAM_FRAME_FORCE_CLOSE=0
   GAMEMODE=1
   vblank_mode=1
   PROTON_LOG=0
   PROTON_USE_WINED3D=0
   PROTON_FORCE_LARGE_ADDRESS_AWARE=1
   PROTON_NO_ESYNC=1
   DXVK_ASYNC=1
   WINE_FULLSCREEN_FSR=1
   WINE_VK_USE_FSR=1
   MESA_BACK_BUFFER=ximage
   MESA_NO_DITHER=1
   MESA_SHADER_CACHE_DISABLE=false
   mesa_glthread=true
   MESA_DEBUG=0
   LIBGL_DEBUG=0
   LIBGL_NO_DRAWARRAYS=0
   LIBGL_THROTTLE_REFRESH=1
   LIBC_FORCE_NOCHECK=1
   LIBGL_DRI3_DISABLE=1
   __GLVND_DISALLOW_PATCHING=1
   __GL_THREADED_OPTIMIZATIONS=1
   __GL_SYNC_TO_VBLANK=1
   __GL_SHADER_DISK_CACHE=0
   __GL_YIELD=NOTHING
   VK_LOG_LEVEL=error
   VK_LOG_FILE=/dev/null
   ANV_ENABLE_PIPELINE_CACHE=1
   LESSSECURE=1
   PAGER=less
   EDITOR=nano
   VISUAL=nano
" | sudo tee -a /etc/environment
sleep 2
clear

echo -e "Firewall settings"
sleep 1
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
clear

echo -e " Cinnamon Settings.."
sleep 1
gsettings set org.cinnamon.desktop.interface icon-theme 'Mint-L'
gsettings set org.cinnamon.desktop.interface gtk-theme 'Mint-L-Darker'
clear

echo ""
echo -e "Creating timeshift backup.."
sleep 2
sudo timeshift --create
clear

echo ""
echo "----------------------------------------------"
echo "       Postinstall is now complete.           "
echo "                 Have fun !!                  "
echo "----------------------------------------------"
echo ""
read -p "..Press any key to reboot the System.."
clear
echo ""
echo "Reboot.."
sleep 1
sudo reboot
