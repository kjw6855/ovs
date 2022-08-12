#!/bin/bash

ovs-ofctl -O OpenFlow13 add-flow s1 priority=20,table=0,in_port=1,dl_type=0x0806,arp_tpa=10.0.0.2,actions=output:2
ovs-ofctl -O OpenFlow13 add-flow s1 priority=20,table=0,in_port=2,dl_type=0x0806,arp_tpa=10.0.0.1,actions=output:1
ovs-ofctl -O OpenFlow13 add-flow s1 priority=10,table=0,in_port=1,dl_type=0x0800,nw_dst=10.0.0.2,actions=push_vlan:0x8100,mod_vlan_vid:2000,output:2
ovs-ofctl -O OpenFlow13 add-flow s1 priority=10,table=0,in_port=2,dl_type=0x0800,nw_dst=10.0.0.1,actions=output:1

ovs-ofctl -O OpenFlow13 add-flow s2 priority=20,table=0,in_port=1,dl_type=0x0806,arp_tpa=10.0.0.1,actions=output:2
ovs-ofctl -O OpenFlow13 add-flow s2 priority=20,table=0,in_port=2,dl_type=0x0806,arp_tpa=10.0.0.2,actions=output:1
ovs-ofctl -O OpenFlow13 add-flow s2 priority=10,table=0,in_port=1,dl_type=0x0800,nw_dst=10.0.0.1,actions=output:2
ovs-ofctl -O OpenFlow13 add-flow s2 priority=10,table=0,in_port=2,dl_type=0x0800,vlan_tci=0x1000/0x1000,nw_dst=10.0.0.2,actions=strip_vlan,output:1
