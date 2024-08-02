INTERVAL="10s"
TIMEOUT="120s"

NAME=test-kvm ;
NODE=cloud1 ;

crm configure <<EOF
 primitive $NAME lsb:$NAME \
 op monitor interval=$INTERVAL timeout=$TIMEOUT \
 op start interval=0 timeout=$TIMEOUT

 location prefered_$NAME $NAME 50: $NODE
EOF