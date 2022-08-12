#!/bin/bash

ovs-ofctl -O OpenFlow13 add-flow s1 priority=20,table=0,in_port=1,dl_type=0x0806,arp_tpa=10.0.0.2,actions=output:2
ovs-ofctl -O OpenFlow13 add-flow s1 priority=20,table=0,in_port=2,dl_type=0x0806,arp_tpa=10.0.0.1,actions=output:1
ovs-ofctl -O OpenFlow13 add-flow s1 priority=10,table=0,in_port=1,dl_type=0x0800,nw_dst=10.0.0.2,actions=push_verify,set_verify_port:1,set_verify_rule:101,pop_verify,output:2
ovs-ofctl -O OpenFlow13 add-flow s1 priority=10,table=0,in_port=2,dl_type=0x0800,nw_dst=10.0.0.1,actions=push_verify,set_verify_port:2,set_verify_rule:102,pop_verify,output:1
ovs-ofctl -O OpenFlow13 add-flow s1 priority=5,table=0,in_port=2,dl_type=0x2080,actions=drop

ovs-ofctl -O OpenFlow13 add-flow s2 priority=20,table=0,in_port=1,dl_type=0x0806,arp_tpa=10.0.0.1,actions=output:2
ovs-ofctl -O OpenFlow13 add-flow s2 priority=20,table=0,in_port=2,dl_type=0x0806,arp_tpa=10.0.0.2,actions=output:1
ovs-ofctl -O OpenFlow13 add-flow s2 priority=10,table=0,in_port=1,dl_type=0x0800,nw_dst=10.0.0.1,actions=push_verify,set_verify_port:1,set_verify_rule:201,pop_verify,output:2
ovs-ofctl -O OpenFlow13 add-flow s2 priority=10,table=0,in_port=2,dl_type=0x0800,nw_dst=10.0.0.2,actions=push_verify,set_verify_port:2,set_verify_rule:202,pop_verify,output:1
