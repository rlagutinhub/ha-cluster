#!/bin/bash

ifconfig enp6s0 10.10.10.1/24
ifconfig enp7s0 172.16.0.1/24

ifconfig lo:1 3.3.3.3/24
ifconfig lo:2 1.1.1.1/24

apt install quagga
