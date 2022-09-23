#!/bin/bash

reflector -c KR -a 6 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacman -Sy

ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
#sed -i '178s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "Arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 Arch.localdomain Arch" >> /etc/hosts

#remember to change the password here default is 1
echo root:1 | chpasswd

pacman -S grub base-devel efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools avahi xdg-user-dirs xdg-utils gvfs
pacman -S gvfs-smb nfs-utils inetutils dnsutils alsa-utils bash-completion rsync reflector acpi openssh
pacman -S acpi_call bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft firewalld sof-firmware nss-mdns acpid ntfs-3g terminus-font 
pacman -S linux-headers  

#pipewire
pacman -S pipewire pipewire-alsa pipewire-pulse pipewire-jack pipewire-x11-bell realtime-privileges wireplumber 
# easyeffects from repo install alot of plugin so either that or easyeffects-git (From AUR)

#pacman -S easyeffects openssh

#pacman -S linux-zen linux-zen-headers

# extra utils

#pacman -S grub-btrfs  bluez bluez-utils cups 

#pacman -S virt-manager qemu qemu-arch-extra edk2-ovmf

# if installing on qemu /kvm

#pacman -S qemu-guest-agent spice-vdagent xf86-video-qxl

# zram-generator

#pacman -S zram-generator

# pacman -S xf86-video-amdgpu 
# pacman -S nvidia nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=UEFI-Arch
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
#systemctl enable bluetooth
#systemctl enable cups.service
#systemctl enable sshd
systemctl enable avahi-daemon
#systemctl enable tlp #uncomment command out if you install tlp
systemctl enable reflector.timer
systemctl enable fstrim.timer
#systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid
systemctl enable qemu-guest-agent #uncomment if installed qemu-guest-agent


#change user name default is jay
useradd -mG wheel jay

#change the password. default is one
echo jay:1 | chpasswd
#usermod -aG libvirt jay

echo "jay ALL=(ALL) ALL" >> /etc/sudoers.d/jay


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

