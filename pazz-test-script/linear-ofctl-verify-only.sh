#!/bin/bash

ovs-ofctl -O OpenFlow13 add-flow s1 priority=20,table=0,in_port=1,dl_type=0x0806,arp_tpa=10.0.0.2,actions=output:2
ovs-ofctl -O OpenFlow13 add-flow s1 priority=20,table=0,in_port=2,dl_type=0x0806,arp_tpa=10.0.0.1,actions=output:1
ovs-ofctl -O OpenFlow13 add-flow s1 priority=10,table=0,in_port=1,dl_type=0x0800,nw_dst=10.0.0.2,actions=push_verify,output:2
ovs-ofctl -O OpenFlow13 add-flow s1 priority=10,table=0,in_port=2,dl_type=0x0800,nw_dst=10.0.0.1,actions=pop_verify,output:1

ovs-ofctl -O OpenFlow13 add-flow s2 priority=20,table=0,in_port=1,dl_type=0x0806,arp_tpa=10.0.0.1,actions=output:2
ovs-ofctl -O OpenFlow13 add-flow s2 priority=20,table=0,in_port=2,dl_type=0x0806,arp_tpa=10.0.0.2,actions=output:1
ovs-ofctl -O OpenFlow13 add-flow s2 priority=10,table=0,in_port=1,dl_type=0x0800,nw_dst=10.0.0.1,actions=push_verify,output:2
ovs-ofctl -O OpenFlow13 add-flow s2 priority=10,table=0,in_port=2,dl_type=0x0800,nw_dst=10.0.0.2,actions=pop_verify,output:1
