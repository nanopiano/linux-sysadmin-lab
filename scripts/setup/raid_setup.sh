#!/bin/bash
# raid_setup.sh
# Sets up RAID 1 and RAID 5 arrays using mdadm
# Run as root on the Rocky Linux storage server

echo "[*] Creating RAID 1 array on /dev/md0 using sdc and sdd..."
mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sdc /dev/sdd

echo "[*] Creating RAID 5 array on /dev/md1 using sde, sdf, and sdg..."
mdadm --create /dev/md1 --level=5 --raid-devices=3 /dev/sde /dev/sdf /dev/sdg

echo "[*] Verifying RAID arrays..."
cat /proc/mdstat

echo "[*] Done."
