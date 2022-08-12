#!/bin/bash

ovs-ofctl -O OpenFlow13 add-flow s1 priority=20,table=0,in_port=2,dl_type=0x0806,arp_tpa=10.0.0.1,actions=output:1
ovs-ofctl -O OpenFlow13 add-flow s1 priority=20,table=0,in_port=1,dl_type=0x0806,arp_tpa=10.0.0.2,actions=output:2
ovs-ofctl -O OpenFlow13 add-flow s1 priority=20,table=0,in_port=1,dl_type=0x0806,arp_tpa=10.0.0.3,actions=output:2
ovs-ofctl -O OpenFlow13 add-flow s1 priority=10,table=0,in_port=2,dl_type=0x0800,nw_dst=10.0.0.1,actions=set_verify_port:12,set_verify_rule:101,pop_verify,output:1
ovs-ofctl -O OpenFlow13 add-flow s1 priority=10,table=0,in_port=1,dl_type=0x0800,nw_dst=10.0.0.2,actions=push_verify,set_verify_port:11,set_verify_rule:102,output:2
ovs-ofctl -O OpenFlow13 add-flow s1 priority=10,table=0,in_port=1,dl_type=0x0800,nw_dst=10.0.0.3,actions=push_verify,set_verify_port:11,set_verify_rule:103,output:2

ovs-ofctl -O OpenFlow13 add-flow s3 priority=20,table=0,in_port=2,dl_type=0x0806,arp_tpa=10.0.0.3,actions=output:1
ovs-ofctl -O OpenFlow13 add-flow s3 priority=20,table=0,in_port=1,dl_type=0x0806,arp_tpa=10.0.0.2,actions=output:2
ovs-ofctl -O OpenFlow13 add-flow s3 priority=20,table=0,in_port=1,dl_type=0x0806,arp_tpa=10.0.0.1,actions=output:2
ovs-ofctl -O OpenFlow13 add-flow s3 priority=10,table=0,in_port=2,dl_type=0x0800,nw_dst=10.0.0.3,actions=set_verify_port:32,set_verify_rule:301,pop_verify,output:1
ovs-ofctl -O OpenFlow13 add-flow s3 priority=10,table=0,in_port=1,dl_type=0x0800,nw_dst=10.0.0.2,actions=push_verify,set_verify_port:31,set_verify_rule:302,output:2
ovs-ofctl -O OpenFlow13 add-flow s3 priority=10,table=0,in_port=1,dl_type=0x0800,nw_dst=10.0.0.1,actions=push_verify,set_verify_port:31,set_verify_rule:303,output:2

ovs-ofctl -O OpenFlow13 add-flow s2 priority=20,table=0,dl_type=0x0806,arp_tpa=10.0.0.1,actions=output:2
ovs-ofctl -O OpenFlow13 add-flow s2 priority=20,table=0,dl_type=0x0806,arp_tpa=10.0.0.2,actions=output:1
ovs-ofctl -O OpenFlow13 add-flow s2 priority=20,table=0,dl_type=0x0806,arp_tpa=10.0.0.3,actions=output:3
ovs-ofctl -O OpenFlow13 add-flow s2 priority=10,table=0,in_port=1,dl_type=0x0800,nw_dst=10.0.0.1,actions=push_verify,set_verify_port:21,set_verify_rule:201,output:2
ovs-ofctl -O OpenFlow13 add-flow s2 priority=10,table=0,in_port=3,dl_type=0x0800,nw_dst=10.0.0.1,actions=set_verify_port:23,set_verify_rule:202,output:2
ovs-ofctl -O OpenFlow13 add-flow s2 priority=10,table=0,in_port=2,dl_type=0x0800,nw_dst=10.0.0.2,actions=set_verify_port:22,set_verify_rule:203,pop_verify,output:1
ovs-ofctl -O OpenFlow13 add-flow s2 priority=10,table=0,in_port=3,dl_type=0x0800,nw_dst=10.0.0.2,actions=set_verify_port:3,set_verify_rule:204,pop_verify,output:1
ovs-ofctl -O OpenFlow13 add-flow s2 priority=10,table=0,in_port=1,dl_type=0x0800,nw_dst=10.0.0.3,actions=push_verify,set_verify_port:21,set_verify_rule:205,output:3
ovs-ofctl -O OpenFlow13 add-flow s2 priority=10,table=0,in_port=2,dl_type=0x0800,nw_dst=10.0.0.3,actions=set_verify_port:22,set_verify_rule:206,output:3
