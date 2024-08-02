#!/bin/bash

ifconfig enp6s0 10.10.10.2/24
ifconfig enp7s0 172.16.0.2/24

ifconfig lo:1 2.2.2.2/24
ifconfig lo:2 4.4.4.4/24

ip route add 1.1.1.1 scope global nexthop via 10.10.10.1 weight 1 nexthop via 172.16.0.1 weight 1
ip route add 3.3.3.3 scope global nexthop via 10.10.10.1 weight 1 nexthop via 172.16.0.1 weight 1