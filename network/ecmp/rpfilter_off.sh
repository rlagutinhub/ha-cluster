#!/bin/bash
sysctl -w net.ipv4.ip_forward=1

echo 0 > /proc/sys/net/ipv4/conf/all/rp_filter

for IF in /proc/sys/net/ipv4/conf/*
do
  echo 0 > $IF/rp_filter
done
