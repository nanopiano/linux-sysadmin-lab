#!/bin/bash
# network_ping.sh
# Pings a target IP and logs connection status with timestamp and hostname
# Scheduled via crontab: every 1 minute

IP="192.168.1.254"
DATE=$(date)
HOST=$(hostname)

ping -c 1 $IP > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "$IP Connection Alive $DATE $HOST" >> /home/student/network_ping.logs
else
    echo "$IP Connection Failure $DATE $HOST" >> /home/student/network_ping.logs
fi
