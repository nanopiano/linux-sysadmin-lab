# Systems Administration Labs

Rocky Linux and Windows Server 2022 lab environment built in private cloud platform. Covers Active Directory, DNS, DHCP, RAID storage, file sharing services, and shell automation.

---

## Environment Overview

| Device | OS | Role |
|---|---|---|
| pfSense | pfSense 2.4.5 | NAT router and gateway |
| Windows Server 2022 | Windows Server 2022 | AD DS, DNS, DHCP, GPO |
| Windows 11 Client | Windows 11 | Domain client |
| Rocky Linux (nadeenmo) | Rocky Linux 9.5 | Domain joined Linux client |
| Rocky Linux (linclient) | Rocky Linux 9.5 | Linux test client |
| Rocky Linux Storage | Rocky Linux 9.5 | RAID, Samba, FTP, RSYNC, NFS |

Network: `192.168.1.0/24` under domain `nma2881.com`

---

## What Was Configured

**Active Directory and Domain Services**
- Domain controller at `nadeen.nma2881.com`
- Two OUs: Accounting and Sales with domain users
- Group Policy Objects: NoCP (Control Panel restriction) and Wallpaper enforcement
- DHCP scope: `192.168.1.1` to `192.168.1.254`, 8-day lease

**RAID Storage**
- RAID 1 on `/dev/md0` using `sdc` and `sdd`, mounted at `/media/nfs1` and `/media/nfs2`
- RAID 5 on `/dev/md1` using `sde`, `sdf`, `sdg`, mounted at `/media/samba1` and `/media/samba2`
- Persistent mounts configured via `/etc/fstab`
- Failure simulation and recovery tested on RAID 5

**File Services**
- FTP via vsftpd with user and anonymous access, logged to `/var/log/xferlog`
- Samba share `[ramones]` with group-based write access for `writers` group
- RSYNC daemon module `[ramones]` for remote file transfers
- NFS export `/media/nfs1/weezer` mounted on both Linux and Windows clients

**Automation**
- Three cron jobs running on the storage server for backups, disk monitoring, and network checks

---

## Repo Structure

```
linux-sysadmin/
├── scripts/
│   ├── databackup.sh         # Versioned backup with rsync
│   ├── diskMonitor.sh        # Disk usage logger
│   ├── network_ping.sh       # Connectivity checker
│   └── setup/
│       ├── raid_setup.sh     # RAID 1 and RAID 5 setup
│       ├── samba_setup.sh    # Samba users, groups, and permissions
│       └── nfs_setup.sh      # NFS export configuration
└── configs/
    ├── smb.conf.example      # Samba config template
    ├── rsyncd.conf.example   # RSYNC daemon config template
    ├── fstab.example         # Persistent mount entries
    └── crontab.example       # Scheduled cron jobs
```

---

## How to Use the Scripts

Make scripts executable before running:

```bash
chmod +x scripts/*.sh
chmod +x scripts/setup/*.sh
```

For RAID setup, run as root on the storage server:

```bash
sudo bash scripts/setup/raid_setup.sh
```

For Samba setup:

```bash
sudo bash scripts/setup/samba_setup.sh
```

For cron jobs, copy entries from `configs/crontab.example` into your crontab:

```bash
crontab -e
```

---

## Skills Demonstrated

- Active Directory administration (OUs, GPOs, DHCP, DNS)
- Software RAID configuration and fault recovery on Linux
- File sharing across Linux and Windows (Samba, NFS, FTP, RSYNC)
- Shell scripting and cron-based automation
- Virtual network setup and management in a private cloud (RLES)

---

> Built as part of NSSA 221 Systems Administration I at RIT Dubai.
