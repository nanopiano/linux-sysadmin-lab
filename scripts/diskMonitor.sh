#!/bin/bash
# diskMonitor.sh
# Logs disk usage with hostname and timestamp to disk_usage.log
# Scheduled via crontab: every 2 minutes

echo "Disk Usage Report - $(date)" >> /home/student/disk_usage.log
hostname >> /home/student/disk_usage.log
df -h >> /home/student/disk_usage.log
echo "----------------------------------------" >> /home/student/disk_usage.log
