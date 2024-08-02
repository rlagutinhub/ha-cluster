/interface vrrp
add interface=br0 name=vrrp1 vrid=1 priority=100
add interface=br0 name=vrrp2 vrid=2 priority=50

/ip address
add address=87.237.237.61/24 interface=ether2 
add address=10.60.10.1/32 interface=vrrp1 
add address=10.60.10.2/32 interface=vrrp2 
add address=10.60.10.253/24 interface=br0 

/ip firewall nat
add action=src-nat chain=srcnat out-interface=ether2 to-addresses=87.237.237.61 

/ip route
add distance=1 gateway=87.237.237.1