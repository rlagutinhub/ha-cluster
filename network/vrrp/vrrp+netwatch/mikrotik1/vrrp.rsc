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

/system script
add dont-require-permissions=yes name=10.60.10.2_down owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=\
    "/interface vrrp set [ /interface vrrp find name=vrrp2] priority=10; "
add dont-require-permissions=yes name=10.60.10.2_up owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=\
    "/interface vrrp set [ /interface vrrp find name=vrrp2] priority=100; "

/tool netwatch
add down-script=10.60.10.2_down host=217.171.171.1 timeout=15s up-script=10.60.10.2_up