#!/bin/bash

qemu-img convert -f raw -O qcow2 /ramdisk/raspbian-buster-lite.img /home/chris/Desktop/raspbian-buster-lite.qcow
guestmount  -a /home/chris/Desktop/raspbian-buster-lite.qcow -m /dev/sda1 /mnt
/home/chris/Desktop/IoPI/installer/installer.sh /mnt
cmdline=$(</mnt/cmdline.txt)
realcmdline=$(</mnt/cmdline.txt.orig)
guestunmount /mnt

sleep 5

qemu-system-arm \
-kernel /home/chris/Desktop/kernel-qemu-4.19.50-buster \
-append "$cmdline" \
-dtb /home/chris/Desktop/versatile-pb.dtb \
-hda /home/chris/Desktop/raspbian-buster-lite.qcow \
-cpu arm1176 -m 256 \
-M versatilepb \
-no-reboot \
-serial stdio 

echo "exited first run."

sleep 5

qemu-system-arm \
-kernel /home/chris/Desktop/kernel-qemu-4.19.50-buster \
-append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" \
-dtb /home/chris/Desktop/versatile-pb.dtb \
-hda /home/chris/Desktop/raspbian-buster-lite.qcow \
-cpu arm1176 -m 256 \
-M versatilepb \
-no-reboot \
-serial stdio 