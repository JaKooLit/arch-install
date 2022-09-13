cheat sheet for arch installation (UEFI)

prepare your drive

lsblk

use cfdisk fdisk cgdisk or any to prepare disk

mkfs.vfat /dev/boot-drive

mkfs.btrfs /dev/root drive

mount /dev/root /mnt

cd /mnt

btrfs subvolume create @

btrfs subvolume create @home

btrfs subvolume create @opt

btrfs subvolume create @var

btfs subvolume create @tmp

btrfs su cr @snapshots - for snapper
cd

umount /mnt

mount -o noatime,compress=zstd:5,space_cache=v2,discard=async,subvol=@ /dev/root /mnt

mkdir /mnt/{boot,home,var,opt,data,.snapshots}

mount -o noatime,compress=zstd:5.space_cache=v2,discard=async,subvol=@home /dev/root /mnt/home

mount -o noatime,compress=zstd:5.space_cache=v2,discard=async,subvol=@opt /dev/root /mnt/opt

mount -o noatime,compress=zstd:5.space_cache=v2,discard=async,subvol=@var /dev/root /mnt/var

mount -o noatime,compress=zstd:5.space_cache=v2,discard=async,subvol=@tmp /dev/root /mnt/tmp

mount -o noatime,compress=zstd:5.space_cache=v2,discard=async,subvol=@snapshots /dev/root /mnt/.snapshots

mount /dev/boot(drive) /mnt/boot

pacstrap /mnt base linux linux-firmware linux-firmware-whence git vim amd-ucode/intel-ucode btrfs-progs

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

install uefi.sh - from the file edit with vim or any text editor downloaded in the pacstrap installation

chmod +x uefi.sh

sudo ./archin-stall/uefi.sh

before reboot after uefi


vim /etc/mkinitcpio.conf

modules add (btrfs amdgpu nvidia) - as applicable

mkinitcpio -P

reflector: (for reflector timer)
/etc/xdg/reflector/reflector.conf

--save /etc/pacman.d/mirrorlist
--protocol https
--country KR,HK,TW,SG,JP
--latest 6
--sort rate

zram:

After installing zram-generator package, configure how much zram you need / want
see https://github.com/systemd/zram-generator
basically

add conf file to

 /etc/systemd/zram-generator.conf
[zram0]
zram-size = ram / 2






