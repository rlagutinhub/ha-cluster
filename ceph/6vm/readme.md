wget -q -O- 'https://download.ceph.com/keys/release.asc' | sudo apt-key add -
echo 'deb http://download.ceph.com/debian-octopus/ bionic main' > /etc/apt/sources.list.d/ceph.list
apt update
sudo apt install qemu-kvm libvirt-bin bridge-utils ceph-common

vim /etc/machineid
virsh net-destroy default
virsh net-undefine default
apparmor=0
virt-host-validate
dmesg -T | grep Nested
options kvm_amd nested=1

scp /etc/libvirt/secrets/* 192.168.1.21:/etc/libvirt/secrets
scp /etc/libvirt/secrets/* 192.168.1.22:/etc/libvirt/secrets
scp /etc/libvirt/secrets/* 192.168.1.23:/etc/libvirt/secrets

scp -r /etc/ceph 192.168.1.21:/etc
scp -r /etc/ceph 192.168.1.22:/etc
scp -r /etc/ceph 192.168.1.23:/etc

virsh dumpxml test-kvm > test-kvm.xml

scp test-kvm.xml 192.168.1.21:/tmp
scp test-kvm.xml 192.168.1.22:/tmp
scp test-kvm.xml 192.168.1.23:/tmp

ssh 192.168.1.21 "virsh define /tmp/test-kvm.xml"
ssh 192.168.1.22 "virsh define /tmp/test-kvm.xml"
ssh 192.168.1.23 "virsh define /tmp/test-kvm.xml"




