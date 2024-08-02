/interface bridge
add name=br0

/interface bonding
add mode=802.3ad name=bond1 slaves=ether10,ether11 transmit-hash-policy=layer-3-and-4

/interface bridge port
add bridge=br0 interface=bond1

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

/system script
add dont-require-permissions=yes name=10.60.10.1_down owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=\
    "/interface vrrp set [ /interface vrrp find name=vrrp1] priority=10; "
add dont-require-permissions=yes name=10.60.10.1_up owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=\
    "/interface vrrp set [ /interface vrrp find name=vrrp1] priority=100; "

/tool netwatch
add down-script=10.60.10.1_down host=87.237.237.1 timeout=15s up-script=10.60.10.1_up