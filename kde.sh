#!/bin/bash

sudo timedatectl set-ntp true
sudo hwclock --systohc

sudo reflector -c KR,HK,TW,SG,JP -a 6 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy

sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload


sudo pacman -S sddm plasma-desktop konsole packagekit-qt5 kwallet-pam ark powerdevil plasma-nm bluedevil firefox spectacle 

sudo pacman -S gwenview vlc kate dolphin bluez bluez-utils

sudo pacman -S dolphin-plugins discover sddm-kcm khotkeys kscreen kgamma5 kinfocenter ksystemlog filelight plasma-pa

#fonts

sudo pacman -S ttf-font-awesome otf-font-awesome ttf-hack adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts noto-fonts-cjk powerline-fonts noto-fonts

#wayland
sudo pacman -S xdg-desktop-portal-kde plasma-wayland-session

#extras

sudo pacman -S print-manager
#edit the packages as required

#plasma-beta or plasma 5.26?
#sudo pacman -S xdg-desktop-portal-kde plasma-wayland-session kpipewire plasma-workspace-wallpapers plasma-integration plasma-disks kwrited kde-gtk-config polkit-kde-agent kactivitymanagerd breeze breeze-grub breeze-gtk
#additional if required

sudo systemctl enable sddm

echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
#sleep 5
#reboot
