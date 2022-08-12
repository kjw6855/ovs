#!/bin/sh
#OVSDB_DIR="/usr/local/etc/openvswitch/"
#rm -rf $OVSDB_DIR
#if [ ! -d $OVSDB_DIR ]; then
#    echo "creating directory"
#    mkdir -p /usr/local/etc/openvswitch
#    cd /home/vagrant/ovs
#    ovsdb-tool create /usr/local/etc/openvswitch/conf.db vswitchd/vswitch.ovsschema
#    cd /home/vagrant/
#fi

echo "Killing the OVSDB-server instance"
pkill ovsdb-server
pkill ovs-vswitchd


echo "starting a new instance of ovsdb-server"
ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock     --remote=db:Open_vSwitch,Open_vSwitch,manager_options     --private-key=db:Open_vSwitch,SSL,private_key     --certificate=db:Open_vSwitch,SSL,certificate     --bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert     --pidfile --detach --log-file


echo "initializing ovs-vsctl"
ovs-vsctl --no-wait init

echo "Deleting s0"
ovs-vsctl --no-wait del-br s0

echo "Adding s0"
ovs-vsctl --no-wait --may-exist add-br s0 -- set bridge s0 datapath_type=netdev

echo "Adding ports"

ovs-vsctl --no-wait --may-exist add-port s0 eth1 -- set Interface eth1 ofport_request=1
ovs-vsctl --no-wait --may-exist add-port s0 eth2 -- set Interface eth2 ofport_request=2
ovs-vsctl --no-wait --may-exist add-port s0 eth3 -- set Interface eth3 ofport_request=3

echo "Starting ovs-vswitch"
export DB_SOCK=/usr/local/var/run/openvswitch/db.sock
ovs-vswitchd unix:$DB_SOCK --pidfile --detach &

ovs-vsctl --no-wait set bridge s0 protocols=OpenFlow13
sleep 1

echo "installing openflow rules"
ovs-ofctl -O OpenFlow13 del-flows s0 table=0
#ovs-ofctl -O OpenFlow13 add-flow s0 priority=10,table=0,in_port=1,dl_type=0x0800,nw_dst=10.1.1.1/28,actions=output:2
#ovs-ofctl -O OpenFlow13 add-flow s0 priority=9,table=0,in_port=1,dl_type=0x0800,nw_dst=10.1.1.1/27,actions=output:3
ovs-ofctl -O OpenFlow13 add-flow s0 priority=10,table=0,in_port=1,dl_type=0x0800,nw_dst=10.1.1.1/28,actions=push_verify,set_verify_rule:1,set_verify_port=1,output:2
ovs-ofctl -O OpenFlow13 add-flow s0 priority=9,table=0,in_port=1,dl_type=0x0800,nw_dst=10.1.1.1/27,actions=push_verify,set_verify_rule:2,set_verify_port=1,output:3
ovs-ofctl -O OpenFlow13 dump-flows s0

