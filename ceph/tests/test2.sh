#!/bin/bash

echo '1 ************************************************************'

for i in `seq 1 10`
do
echo '##############################################################'
echo 'rados bench -p scbench 10 write --no-cleanup'
echo `date +%F_%T`
echo '##############################################################'

  rados bench -p scbench 10 write --no-cleanup ;
done

sleep 600
echo '2 ************************************************************'

for i in `seq 1 10`
do
echo '##############################################################'
echo 'rados bench -p scbench 10 seq ;'
echo `date +%F_%T`
echo '##############################################################'
  rados bench -p scbench 10 seq ;
done

sleep 600
echo '3 ************************************************************'

for i in `seq 1 10`
do
echo '##############################################################'
echo 'rados bench -p scbench 10 rand ;'
echo `date +%F_%T`
echo '##############################################################'
  rados bench -p scbench 10 rand ;
done


sleep 600
echo '4 ************************************************************'

for i in `seq 1 10`
do
echo '##############################################################'
echo 'rbd bench-write image01 --pool=rbdbench ;'
echo `date +%F_%T`
echo '##############################################################'
  rbd bench-write image01 --pool=rbdbench ;
done

####################################################################

sleep 600
echo '5 ************************************************************'

for i in `seq 1 10`
do
echo '##############################################################'
echo 'fio -ioengine=rbd -direct=1 -name=test -bs=4M -iodepth=16 -rw=write -pool=scbench -runtime=60 -rbdname=image01 '
echo `date +%F_%T`
echo '##############################################################'
  fio -ioengine=rbd -direct=1 -name=test -bs=4M -iodepth=16 -rw=write -pool=scbench -runtime=60 -rbdname=image01
done

sleep 600
echo '6 ************************************************************'

for i in `seq 1 10`
do
echo '##############################################################'
echo 'fio -ioengine=rbd -direct=1 -name=test -bs=4k -iodepth=1 -rw=randwrite -pool=scbench -runtime=60 -rbdname=image01 '
echo `date +%F_%T`
echo '##############################################################'
   fio -ioengine=rbd -direct=1 -name=test -bs=4k -iodepth=1 -rw=randwrite -pool=scbench -runtime=60 -rbdname=image01
done

sleep 600
echo '7 ************************************************************'

for i in `seq 1 10`
do
echo '##############################################################'
echo 'fio -ioengine=rbd -direct=1 -name=test -bs=4k -iodepth=128 -rw=randwrite -pool=scbench -runtime=60 -rbdname=image01'
echo `date +%F_%T`
echo '##############################################################'
   fio -ioengine=rbd -direct=1 -name=test -bs=4k -iodepth=128 -rw=randwrite -pool=scbench -runtime=60 -rbdname=image01
done

sleep 600
echo '8 ************************************************************'

for i in `seq 1 10`
do
echo '##############################################################'
echo 'fio -ioengine=rbd -direct=1 -name=test -bs=4M -iodepth=16 -rw=read -pool=scbench -runtime=60 -rbdname=image01'
echo `date +%F_%T`
echo '##############################################################'
  fio -ioengine=rbd -direct=1 -name=test -bs=4M -iodepth=16 -rw=read -pool=scbench -runtime=60 -rbdname=image01
done

sleep 600
echo '9 ************************************************************'

for i in `seq 1 10`
do
echo '##############################################################'
echo 'fio -ioengine=rbd -direct=1 -name=test -bs=4k -iodepth=1 -rw=randread -pool=scbench -runtime=60 -rbdname=image01'
echo `date +%F_%T`
echo '##############################################################'
   fio -ioengine=rbd -direct=1 -name=test -bs=4k -iodepth=1 -rw=randread -pool=scbench -runtime=60 -rbdname=image01
done

sleep 600
echo '10 ************************************************************'

for i in `seq 1 10`
do
echo '##############################################################'
echo 'fio -ioengine=rbd -direct=1 -name=test -bs=4k -iodepth=128 -rw=randread -pool=scbench -runtime=60 -rbdname=image01'
echo `date +%F_%T`
echo '##############################################################'
  fio -ioengine=rbd -direct=1 -name=test -bs=4k -iodepth=128 -rw=randread -pool=scbench -runtime=60 -rbdname=image01
done

