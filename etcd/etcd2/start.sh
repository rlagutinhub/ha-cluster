killall etcd ;

ETCDCTL_API=3 ./etcd \
--name infra1 \
--data-dir /var/lib/etcd \
--listen-client-urls 'https://188.225.34.75:2379' \
--advertise-client-urls 'https://188.225.34.75:2379' \
--listen-peer-urls 'https://188.225.34.75:2380' \
--initial-advertise-peer-urls 'https://188.225.34.75:2380' \
--initial-cluster-token etcd-cluster-3 \
--initial-cluster 'infra0=https://81.20.102.155:2380,infra1=https://188.225.34.75:2380,infra2=https://87.237.235.78:2380' \
--initial-cluster-state new \
--cert-file=certs/188.225.34.75.pem \
--key-file=certs/188.225.34.75-key.pem \
--peer-cert-file=certs/peer-188.225.34.75.pem \
--peer-key-file=certs/peer-188.225.34.75-key.pem \
--peer-client-cert-auth \
--peer-trusted-ca-file=certs/ca.pem &
