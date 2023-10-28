Arch install cheat sheet

Prepare your Hard disk accordingly. For the following, set up is for btrfs

use cfdisk fdisk cgdisk or any to prepare disk
ie. /dev/nvme0n1 - nvme drive

create atleast 100mb for EFI
nvme0n1p1 - EFI
nvme0n1p2 - root

mkfs.vfat /dev/nvme0n1p1
mkfs.btrfs /dev/nvme0n1p2

mount /dev/nvme0n1p2 /mnt

cd /mnt

now create subvolumes
btrfs su cr @
btrfs su cr @home
btrfs su cr @opt
btrfs su cr @var
btrfs su cr @snapshots - for snapper

cd
umount /mnt

mount the root partition
mount -o noatime,compress=zstd:5,space_cache=v2,discard=async,subvol=@ /dev/nvme0n1p2 /mnt

create directories for the btrfs subvolum mount points
mkdir /mnt/{efi,home,var,opt,tmp,.snapshots}

mount the rest of the subvolumes
mount -o noatime,compress=zstd:5.space_cache=v2,discard=async,subvol=@home /dev/nvme0n1p2 /mnt/home
mount -o noatime,compress=zstd:5.space_cache=v2,discard=async,subvol=@opt /dev/nvme0n1p2 /mnt/opt
mount -o noatime,compress=zstd:5.space_cache=v2,discard=async,subvol=@var /dev/nvme0n1p2 /mnt/var
mount -o noatime,compress=zstd:5.space_cache=v2,discard=async,subvol=@snapshots /dev/nvme0n1p2 /mnt/.snapshots

mount the EFI partition
mount /dev/nvme0n1p1 /mnt/efi

(OPTIONAL but recommended) Before pacstrap, edit /etc/pacman.conf and enable parallel downloads
nano /etc/pacman.conf

pacman -Sy to synchronize first 

pacstrap into /mnt. Choose the proper cpu microcode for your chip
pacstrap /mnt base linux linux-firmware linux-firmware-whence git vim amd-ucode/intel-ucode btrfs-progs

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

download this repo
git clone https://github.com/JaKooLit/arch-install


install uefi.sh - from the file edit with vim or any text editor downloaded in the pacstrap installation

chmod +x uefi.sh

cd
/archin-stall/uefi.sh

before reboot after uefi.sh

vim or nano /etc/mkinitcpio.conf

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

test




