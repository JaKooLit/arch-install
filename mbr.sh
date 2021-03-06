#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "Arch-Saeron" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 Arch-Saeron.localdomain Arch-Saeron" >> /etc/hosts
echo root:password | chpasswd

pacman -S grub networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools reflector base-devel linux-lts-headers avahi xdg-user-dirs xdg-utils nfs-utils inetutils dnsutils  alsa-utils pulseaudio bash-completion openssh rsync reflector acpi acpi_call  bridge-utils dnsmasq  openbsd-netcat iptables-nft ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font

# pacman -S xf86-video-amdgpu 
# pacman -S nvidia nvidia-utils nvidia-settings

# additional if required
# pacman -S tlp virt-manager qemu qemu-arch-extra edk2-ovmf vde2 bluez bluez-utils cups hplip gvfs gvfs-smb

# replace sdx with your disk name, not the partition
grub-install --target=i386-pc /dev/sdX 
grub-mkconfig -o /boot/grub/grub.cfg


systemctl enable NetworkManager
# systemctl enable bluetooth
# systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
#systemctl enable tlp # You can uncomment this command out if you install tlp
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid

useradd -mG wheel saeron
echo saeron:password | chpasswd
# usermod -aG libvirt saeron

echo "saeron ALL=(ALL) ALL" >> /etc/sudoers.d/saeron


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
