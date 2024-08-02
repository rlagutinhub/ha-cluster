/interface vrrp
add interface=br0 name=vrrp1 vrid=1 priority=50
add interface=br0 name=vrrp2 vrid=2 priority=100

/ip address
add address=10.60.10.254/24 interface=br0 
add address=217.171.171.43/24 interface=ether1 
add address=10.60.10.1/32 interface=vrrp1 
add address=10.60.10.2/32 interface=vrrp2 

/ip firewall nat
add action=src-nat chain=srcnat out-interface=ether1 to-addresses=217.171.171.43

/ip route
add distance=1 gateway=217.171.171.1
