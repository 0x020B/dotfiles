#!/bin/sh
disk='/dev/sda'
swapfile='/mnt/swap'
self="$(dirname $0)"
sfdisk --delete "$disk"
parted "$disk" mklabel gpt mkpart ESP fat32 1M 513M
parted "$disk" mkpart primary btrfs 513M 100%
mkfs.btrfs -n 32k "$disk"2
mount -vo compress=lzo "$disk"2 /mnt
btrfs -v subvolume create /mnt/@
btrfs -v subvolume create /mnt/@etc
btrfs -v subvolume create /mnt/@home
btrfs -v subvolume create /mnt/@var
umount /mnt
mount -vo noatime,nodiratime,compress=lzo,subvol=@	"$disk"2 /mnt
mkdir -v /mnt/{boot,etc,home,var}
mount -v "$disk"1 /mnt/boot
mount -vo noatime,nodiratime,compress=lzo,subvol=@etc	"$disk"2 /mnt/etc
mount -vo noatime,nodiratime,compress=lzo,subvol=@home	"$disk"2 /mnt/home
mount -vo noatime,nodiratime,compress=lzo,subvol=@var	"$disk"2 /mnt/var
truncate -s 0 "$swapfile"
chattr +C "$swapfile"
fallocate -l 8G "$swapfile"
chmod 0600 "$swapfile"
mkswap "$swapfile"
swapon "$swapfile"
cp -fv $self/etc/pacman.conf /etc
cp -fv $self/etc/pacman.d/* /etc/pacman.d/
git submodule update --checkout
for key in "alhp-keyring"
do
	cd $self/$key
	makepkg -i
	cd ..
done
pacman -Sy
sed -i 's#/mirrorlist#/*#g' /bin/pacstrap
pacstrap -K /mnt	base-devel-selinux	amd-ucode	linux-zen		linux-firmware		btrfs-progs		duperemove	\
			dhcpcd			wpa_supplicant	zsh			oh-my-zsh-git		vim			neovim		\
			man-db			man-pages	xf86-video-amdgpu	vulkan-radeon		libva-mesa-driver	mesa-vdpau	\
			obs-studio		xorg-xwayland	sway			yakuake			firejail		bat		\
			rsync			colordiff	aria2			neomutt			isync			goimapnotify
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt ln -svf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc --adjfile /mnt/etc/adjtime
cp -v $self/etc/* /mnt/etc/
#semanage fcontext -a -t swapfile_t "$swapfile"
#restorecon "$swapfile"
arch-chroot /mnt mkinitcpio -P
arch-chroot /mnt useradd -m -G wheel -s /usr/bin/zsh n0tr00t
arch-chroot /mnt passwd n0tr00t
efibootmgr --create --disk "$disk" --part 1 \
	--label 'Linux' \
	--loader /vmlinuz-linux-zen \
	--unicode "root=$(findmnt -no UUID /mnt)"' rootflag=subvol=@ rw initrd=\amd-ucode.img initrd=\initramfs-linux-zen.img'
umount -Rv /mnt
