#!/bin/bash

ifconfig enp6s0 10.10.10.1/24
ifconfig enp7s0 172.16.0.1/24

ifconfig lo:1 3.3.3.3/24
ifconfig lo:2 1.1.1.1/24

ip route add 2.2.2.2 scope global nexthop via 10.10.10.2 weight 1 nexthop via 172.16.0.2 weight 1
ip route add 4.4.4.4 scope global nexthop via 10.10.10.2 weight 1 nexthop via 172.16.0.2 weight 1
