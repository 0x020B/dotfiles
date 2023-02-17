vmlinuz-linux-zen cryptdevice=/dev/sda2:fs cryptkey=/dev/sda1:vfat:diskkey \
		root=/dev/mapper/fs rootflags=noatime,nodiratime,compress=lzo,subvol=@ rw \
		usr=/dev/mapper/fs usrflags=noatime,nodiratime,compress=lzo,subvol=@usr rw \
		lsm=landlock,lockdown,yama,integrity,selinux,bpf \
		initrd=amd-ucode.img initrd=initramfs-linux-zen.img
