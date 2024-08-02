#!/bin/bash

ifconfig enp9s0 0.0.0.0
brctl addbr br0
brctl addif br0 enp9s0
ifconfig br0 192.168.10.25/24
ifconfig br0:1 192.168.1.20/24
ip ro add default via 192.168.10.30
echo "nameserver 8.8.8.8" > /etc/resolv.conf

iptables -t nat -I POSTROUTING -s 192.168.1.0/24 ! -d 192.168.1.0/24 -j SNAT --to-source 192.168.10.25
