#!/bin/bash

#На хостовой машине
iptables -F
iptables -F -t nat
iptables -F -t mangle

iptables -X
iptables -X -t nat
iptables -X -t mangle

#wlp2s0 - инерфейс с интернетом
iptables -t nat -A POSTROUTING -o wlp2s0 -j MASQUERADE

brctl addbr br1
brctl addbr br2
ifconfig br1 10.10.10.254/24 up
ifconfig br2 172.16.0.254/24 up