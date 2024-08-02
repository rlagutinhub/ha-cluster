RESOURCE=test-kvm
crm resource stop $RESOURCE &&
crm resource unmanage $RESOURCE &&
crm configure delete $RESOURCE