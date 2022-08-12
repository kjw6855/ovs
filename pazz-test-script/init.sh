#!/bin/sh
OVSDB_DIR="/usr/local/etc/openvswitch/"
rm -rf $OVSDB_DIR
if [ ! -d $OVSDB_DIR ]; then
    echo "creating directory"
    mkdir -p $OVSDB_DIR
    ovsdb-tool create "$OVSDB_DIR"/conf.db /home/intender/Workspace/ovs/vswitchd/vswitch.ovsschema
fi

echo "Killing the OVSDB-server instance"
pkill ovsdb-server
pkill ovs-vswitchd


echo "starting a new instance of ovsdb-server"
ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock     --remote=db:Open_vSwitch,Open_vSwitch,manager_options     --private-key=db:Open_vSwitch,SSL,private_key     --certificate=db:Open_vSwitch,SSL,certificate     --bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert     --pidfile --detach --log-file


echo "initializing ovs-vsctl"
ovs-vsctl --no-wait init

echo "Starting ovs-vswitch"
export DB_SOCK=/usr/local/var/run/openvswitch/db.sock
ovs-vswitchd unix:$DB_SOCK --pidfile --detach &

sleep 1
