crm configure property stonith-enabled=false ;
crm configure property stonith-action=off ; #default reboot
crm resource stop ipmi-cloud1 ;
sleep 3 ;
crm configure delete ipmi-cloud1 ;


crm configure <<EOF
primitive ipmi-cloud1 stonith:external/ipmi \
        params hostname=cloud1 ipaddr=192.168.1.21 \
        userid=Administrator passwd=ipmipassword \
        interface=lanplus

location l-avoid-cloud1 ipmi-cloud1 -inf: cloud1

EOF

crm configure property stonith-enabled=true