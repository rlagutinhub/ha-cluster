#!/bin/bash

brctl addbr public-br0
brctl addbr cluster-br0

ifconfig cluster-br0 10.10.10.1/24

iptables -t nat -A POSTROUTING -s 192.168.1.0/24 ! -d 192.168.1.0/24 -j SNAT --to-source 192.168.10.20

ifconfig eth0 0.0.0.0
brctl addif public-br0 eth0
ifconfig public-br0 192.168.10.20/24
ifconfig public-br0:1 192.168.1.1/24

ip route add default via 192.168.10.30


