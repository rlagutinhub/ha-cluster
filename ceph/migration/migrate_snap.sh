#!/bin/bash

FILENAME=mo_crm_1

rbd -c ./export/ceph.conf --keyring ./export/ceph.client.admin.keyring snap create rbd/$FILENAME@snapshot.backup
rbd -c ./export/ceph.conf --keyring ./export/ceph.client.admin.keyring snap ls $FILENAME

SNAPNAME=$FILENAME@snapshot.backup

rbd -c ./import/ceph.conf --keyring ./import/ceph.client.admin.keyring rm rbd/$FILENAME
rbd -c ./export/ceph.conf --keyring ./export/ceph.client.admin.keyring export rbd/$SNAPNAME - | rbd -c ./import/ceph.conf --keyring ./import/ceph.client.admin.keyring --dest-pool rbd import - $FILENAME
rbd -c ./import/ceph.conf --keyring ./import/ceph.client.admin.keyring feature disable  rbd/$FILENAME exclusive-lock, object-map, fast-diff

rbd -c ./export/ceph.conf --keyring ./export/ceph.client.admin.keyring snap rm rbd/$SNAPNAME
