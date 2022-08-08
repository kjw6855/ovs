#ifndef VERIFY_H
#define VERIFY_H 1

/* PAZZ */

#include <linux/if_ether.h>
#include <linux/netdevice.h>

#define VERIFY_HLEN         8
#define ETH_TYPE_PAZZ       0x2080

struct verify_hdr {
    __be16 eth_type;
    __be16 verify_rule;
    __be32 verify_port;
};

#endif  /* verify.h */
