#!/bin/bash

WG_INTERFACE = "wg0"
CONTAINER_IP = "192.168.22.3"
WG_PEER_IP = "192.168.3.6"
CONFIG_FILE = "/etc/wireguard/wg0.conf"

sudo ip link add $WG_INTERFACE type wireguard
sudo ip -4 address add $WG_PEER_IP dev $WG_INTERFACE
sudo ip rule add from $CONTAINER_IP table 200
sudo ip route add 0.0.0.0/0 via $WG_PEER_IP dev $WG_INTERFACE table 200
sudo wg setconf $WG_INTERFACE $CONFIG_FILE
sudo ip link set $WG_INTERFACE up

echo "All traffic from $CONTAINER_IP will now be routed through $WG_INTERFACE"
