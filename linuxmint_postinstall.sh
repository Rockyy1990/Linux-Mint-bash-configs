#!/usr/bin/env bash

# Last Edit: 19.02.2025

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
echo "2. Add various PPAs for graphics drivers, apps"
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

sudo apt autoremove -y hypnotix redshift pix pix-data transmission-gtk zfs-zed zfsutils-linux libzfs4linux 
sudo apt remove --purge -y libreoffice*
sudo apt remove --purge -y rhythmbox*
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


echo -e "Latest point release of Mesa plus select non-invasive early backports"
sleep 1
sudo add-apt-repository -y ppa:kisak/kisak-mesa
clear

echo -e "Extra up to date Apps"
sleep 1
sudo add-apt-repository -y ppa:xtradeb/apps
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
sudo apt install -y linux-xanmod-x64v3
clear

sudo apt install --install-recommends winehq-staging
clear


echo -e "Install system packages"
sleep 2
sudo apt install -y build-essential curl f2fs-tools xfsdump samba curl vulkan-tools libfsntfs1t64 git mintupgrade zenity 
sudo apt install -y synaptic gnome-firmware wayland-protocols gsmartcontrol fakeroot winbind libnss-winbind ttf-mscorefonts-installer

echo "fastfetch" | sudo tee -a ~/.bashrc

#echo -e "Liquorix Kernel"
#sleep 1
#curl -s 'https://liquorix.net/install-liquorix.sh' | sudo bash
#clear


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
sudo apt install -y steam wine-binfmt libwinpr3-3 libfaudio0 libgdiplus 
sudo apt install -y protontricks proton-caller libvkd3d1 libvkd3d-shader1 goverlay
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
flatpak install -y flathub io.github.giantpinkrobots.varia
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
clear

sudo systemctl enable fstrim.timer
sudo fstrim -av
clear

echo ""
echo -e "Set environment variables "
echo -e "
CPU_LIMIT=0
CPU_GOVERNOR=performance
GPU_USE_SYNC_OBJECTS=1
PYTHONOPTIMIZE=1
ELEVATOR=kyber
TRANSPARENT_HUGEPAGES=always
MALLOC_CONF=background_thread:true
MALLOC_CHECK=0
MALLOC_TRACE=0
LD_DEBUG_OUTPUT=0
LP_PERF=no_mipmap,no_linear,no_mip_linear,no_tex,no_blend,no_depth,no_alphatest
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
PROTON_USE_FSYNC=1
DXVK_ASYNC=1
WINE_FSR_OVERRIDE=1
WINE_FULLSCREEN_FSR=1
WINE_VK_USE_FSR=1
WINEFSYNC_FUTEX2=1
WINEFSYNC_SPINCOUNT=24
MESA_BACK_BUFFER=ximage
MESA_NO_DITHER=0
MESA_SHADER_CACHE_DISABLE=false
mesa_glthread=true
MESA_DEBUG=0
GALLIUM_DRIVER=zink
GALLIUM_NOSW=1
MESA_VK_ENABLE_SUBMIT_THREAD=1
STAGING_SHARED_MEMORY=1
STAGING_AUDIO_PERIOD=13333
STAGING_RT_PRIORITY_BASE=2
ANV_ENABLE_PIPELINE_CACHE=1
LIBGL_DEBUG=0
LIBGL_NO_DRAWARRAYS=0
LIBGL_THROTTLE_REFRESH=1
LIBC_FORCE_NOCHECK=1
__GLX_VENDOR_LIBRARY_NAME=mesa
__GLVND_DISALLOW_PATCHING=0
__GL_THREADED_OPTIMIZATIONS=1
__GL_SYNC_TO_VBLANK=1
__GL_SHADER_DISK_CACHE=0
__GL_YIELD=USLEEP
__GL_MaxFramesAllowed=1
__GL_VRR_ALLOWED=0
VK_LOG_LEVEL=error
VK_LOG_FILE=/dev/null
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

echo -e "Enable tmpfs ramdisk"
sudo sed -i -e '/^\/\/tmpfs/d' /etc/fstab
echo -e "
tmpfs /var/tmp tmpfs nodiratime,nodev,nosuid,mode=1777 0 0
tmpfs /var/log tmpfs nodiratime,nodev,nosuid,mode=1777 0 0
tmpfs /var/run tmpfs nodiratime,nodev,nosuid,mode=1777 0 0
tmpfs /var/lock tmpfs nodiratime,nodev,nosuid,mode=1777 0 0
tmpfs /var/cache tmpfs nodiratime,nodev,nosuid,mode=1777 0 0
tmpfs /var/volatile tmpfs nodiratime,nodev,nosuid,mode=1777 0 0
tmpfs /var/spool tmpfs nodiratime,nodev,nosuid,mode=1777 0 0
tmpfs /media tmpfs nodiratime,nodev,nosuid,mode=1777 0 0
tmpfs /dev/shm tmpfs nodiratime,nodev,nosuid,mode=1777 0 0
" | sudo tee -a /etc/fstab
clear

## Set some ulimits to unlimited
echo -e "
* soft nofile 524288
* hard nofile 524288
root soft nofile 524288
root hard nofile 524288
* soft as unlimited
* hard as unlimited
root soft as unlimited
root hard as unlimited
* soft memlock unlimited
* hard memlock unlimited
root soft memlock unlimited
root hard memlock unlimited
* soft core unlimited
* hard core unlimited
root soft core unlimited
root hard core unlimited
* soft nproc unlimited
* hard nproc unlimited
root soft nproc unlimited
root hard nproc unlimited
* soft sigpending unlimited
* hard sigpending unlimited
root soft sigpending unlimited
root hard sigpending unlimited
* soft stack unlimited
* hard stack unlimited
root soft stack unlimited
root hard stack unlimited
* soft data unlimited
* hard data unlimited
root soft data unlimited
root hard data unlimited
" | sudo tee /etc/security/limits.conf

## Set realtime to unlimited
echo -e "
@realtime - rtprio 99
@realtime - memlock unlimited
" | sudo tee -a /etc/security/limits.conf


echo -e "Enable compose cache on disk"
sudo mkdir -p /var/cache/libx11/compose
mkdir -p /home/$USER/.compose-cache
touch /home/$USER/.XCompose


## Improve NVME
if $(find /sys/block/nvme[0-9]* | grep -q nvme); then
    echo -e "options nvme_core default_ps_max_latency_us=0" | sudo tee /etc/modprobe.d/nvme.conf
fi

## Improve PCI latency
sudo setpci -v -d *:* latency_timer=48 >/dev/null 2>&1


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
