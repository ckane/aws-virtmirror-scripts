#!/bin/bash
echo -e 'g\nw' | fdisk /dev/nvme1n1
sleep 1
echo -e 'n\n\n\n\nw' | fdisk /dev/nvme1n1
sleep 1
mkfs.ext4 -j /dev/nvme1n1p1
mount /dev/nvme1n1p1 /buffer
chgrp wheel /buffer
chmod g+w /buffer
