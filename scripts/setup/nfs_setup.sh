#!/bin/bash
# nfs_setup.sh
# Configures NFS export for /media/nfs1/weezer
# Run as root on the Rocky Linux storage server

echo "[*] Installing nfs-utils..."
dnf install -y nfs-utils

echo "[*] Creating NFS share directory..."
mkdir -p /media/nfs1/weezer

echo "[*] Adding export rule to /etc/exports..."
echo "/media/nfs1/weezer *(rw,sync,no_root_squash)" >> /etc/exports

echo "[*] Exporting shares..."
exportfs -arv

echo "[*] Starting and enabling NFS server..."
systemctl enable --now nfs-server

echo "[*] Verifying NFS is listening on port 2049..."
netstat -an | grep 2049

echo "[*] Done."
