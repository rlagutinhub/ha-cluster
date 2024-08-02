#!/bin/bash

readonly action=$1
readonly role=$2
readonly cluster_name=$3

#vip=10.104.10.210
#dev=eth0
vip=10.60.10.24
dev=eth2

function usage() {
    echo "Usage: $0 <on_start|on_stop|on_role_change> <role> <cluster_name>"
    exit 1
}
  
echo "this is patroni callback `whoami` $action $role $cluster_name" >> /var/log/patroni/callback.log
  
case $action in
    on_stop)
        sudo /sbin/ip addr del ${vip}/24 dev $dev 2>/dev/null
        ;;
    on_start)
        ;;
    on_role_change)
        if [[ $role == 'master' ]]; then
            # VIP
            sudo /sbin/ip addr add ${vip}/24 dev $dev 2>/dev/null
            sudo /usr/sbin/arping -q -A -c 1 -I $dev -S $vip -B
        else
            sudo /sbin/ip addr del ${vip}/24 dev $dev 2>/dev/null
        fi
        ;;
    on_reload)
        ;;
    *)
        usage
        ;;
esac
