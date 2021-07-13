#!/bin/bash

sudo timedatectl set-ntp true
sudo hwclock --systohc

sudo reflector -c KR,HK,TW,SG,JP -a 6 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy

sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload


#paru -S --noconfirm auto-cpufreq
#sudo systemctl enable --now auto-cpufreq
#systemctl start auto-cpufreq

sudo pacman -S xorg deepin deepin-extra lightdm noto-fonts ttf-hack adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts noto-fonts-cjk firefox spectacle vlc powerline powerline-fonts neofetch deepin-session-shell


sudo systemctl enable lightdm.service

/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
#sleep 5
reboot
