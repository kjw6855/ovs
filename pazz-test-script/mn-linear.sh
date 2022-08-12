#!/bin/bash

if [ $# -ne 1 ]; then
    echo "$0 [host-num]"
    exit
fi

mn --topo linear,$1 --controller none --switch ovs,protocols=OpenFlow13
