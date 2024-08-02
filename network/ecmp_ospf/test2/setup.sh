#!/bin/bash

ifconfig enp6s0 10.10.10.2/24
ifconfig enp7s0 172.16.0.2/24

ifconfig lo:1 2.2.2.2/24
ifconfig lo:2 4.4.4.4/24

apt install quagga