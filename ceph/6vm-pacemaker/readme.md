ssh root@192.168.1.21 "echo -e '192.168.1.21 cloud1\n192.168.1.22 cloud2\n192.168.1.23 cloud3\n' >>/etc/hosts"
ssh root@192.168.1.22 "echo -e '192.168.1.21 cloud1\n192.168.1.22 cloud2\n192.168.1.23 cloud3\n' >>/etc/hosts"
ssh root@192.168.1.23 "echo -e '192.168.1.21 cloud1\n192.168.1.22 cloud2\n192.168.1.23 cloud3\n' >>/etc/hosts"

ssh root@192.168.1.21 "echo StrictHostKeyChecking no >> /etc/ssh/ssh_config"
ssh root@192.168.1.22 "echo StrictHostKeyChecking no >> /etc/ssh/ssh_config"
ssh root@192.168.1.23 "echo StrictHostKeyChecking no >> /etc/ssh/ssh_config"


scp test-kvm root@192.168.1.21:/etc/init.d
scp test-kvm root@192.168.1.22:/etc/init.d
scp test-kvm root@192.168.1.23:/etc/init.d

ssh root@192.168.1.22 "/etc/init.d/test-kvm start"

scp add_resourse.sh root@192.168.1.21:/tmp
scp del_resource.sh root@192.168.1.21:/tmp


rbd feature disable rbd/bionic-server-cloudimg-amd64.img exclusive-lock object-map

scp corosync.conf root@192.168.1.21:/etc/corosync
scp corosync.conf root@192.168.1.22:/etc/corosync
scp corosync.conf root@192.168.1.23:/etc/corosync


**Частои спользуемые команды pacemaker
---
crm resource cleanup test-kvm #очистить счетчики падений на ресурсе
crm configure show #посмотреть текущую конфигурацию ресурсов
crm resource start #стартовать ресурс запускает /etc/init.d/test-kvm start
crm resource stop #остановить ресурс запускает /etc/init.d/test-kvm stop
crm resource unmanage #перестает отслежтвать ресурс, можем делать например live migration
crm resource manage #вернуть ресурс под управление pacemaker-а
crm ra [lsb, ocf, service, stonith, systemd] #показывает готовые ресурсы pacemaker-а

