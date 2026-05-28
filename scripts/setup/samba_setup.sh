#!/bin/bash
# samba_setup.sh
# Creates Samba users, groups, and sets share permissions
# Run as root on the Rocky Linux storage server

echo "[*] Creating system users..."
for i in joey johnny deedee marky; do
    useradd -s /sbin/nologin $i
done

echo "[*] Creating writers group..."
groupadd writers

echo "[*] Adding joey, johnny, deedee to writers group..."
for i in joey johnny deedee; do
    usermod -aG writers $i
done

echo "[*] Setting Samba passwords (you will be prompted for each)..."
for i in joey johnny deedee marky; do
    smbpasswd -a $i
done

echo "[*] Setting group and permissions on Samba share..."
chgrp writers /media/samba/ramones
chmod g+rwx /media/samba/ramones

echo "[*] Done. Verify with: smbstatus"
