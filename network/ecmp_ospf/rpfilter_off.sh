#!/bin/bash
sysctl -w net.ipv4.conf.all.forwarding=1
sysctl -w net.ipv4.conf.all.proxy_arp=1
sysctl -w net.ipv4.conf.default.rp_filter=0
sysctl -w net.ipv4.conf.all.rp_filter=0

for IF in /proc/sys/net/ipv4/conf/*
do
  echo 0 > $IF/rp_filter
done
