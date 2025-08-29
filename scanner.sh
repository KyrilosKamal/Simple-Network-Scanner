#!/bin/bash

read -p "Enter Network ID (e.g. 192.168.1): " networkID
read -p "Enter the start range: " start
read -p "Enter the end range: " end

regex='^[0-9]+\.[0-9]+\.[0-9]+$'
if ! [[ "$networkID" =~ $regex ]]; then
  echo "Invalid network ID"
  exit 1
fi

if (( start < 1 || end > 254 || start > end )); then
  echo "Invalid range"
  exit 1
fi

echo -e "\n Scanning from $networkID.$start to $networkID.$end..."
echo "===================================================================="

liveDeviceCount=0
downDeviceCount=0

for i in $(seq "$start" "$end"); do
  ip="$networkID.$i"
  if ping -c 1 -W 1 "$ip" &> /dev/null; then
    echo "===================================================================="
    echo "Host $ip UP"
    ((liveDeviceCount++))
  else
    echo "Host $ip Down"
    ((downDeviceCount++))
  fi
done

# Report
echo "===================================================================="
echo "Scan Report:"
echo "Up Devices:   $liveDeviceCount"
echo "Down Devices: $downDeviceCount"
echo "Total Scanned: $((liveDeviceCount + downDeviceCount))"
