#!/bin/bash
set -e

echo "[!] RC CAR KILL SWITCH ACTIVATED"

# 1 Stop active tools
pkill -9 aircrack-ng || true
pkill -9 wifite || true
pkill -9 bettercap || true
pkill -9 hcxdumptool || true
pkill -9 tcpdump || true

# 2 Stop AP / rogue services
systemctl stop hostapd || true
systemctl stop dnsmasq || true

# 3 Unmount secure vault
fusermount -u /home/pi/securedata || true

# 4 Clear RAM caches
sync
echo 3 > /proc/sys/vm/drop_caches

# 5 Lock vault
chmod 000 /home/pi/securedata.enc

# 6 Shutdown device
shutdown -h now

