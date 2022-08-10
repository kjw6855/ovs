#ifndef VERIFY_H
#define VERIFY_H 1

/* PAZZ */

#include <linux/if_ether.h>
#include <linux/netdevice.h>

/* comment out for debug mode */
//#define PAZZ_DEBUG

#define VERIFY_HLEN         8
#define ETH_TYPE_PAZZ       0x2080

#define ETH_ADDR_FMT                                                    \
    "%02x:%02x:%02x:%02x:%02x:%02x"
#define ETH_ADDR_ARGS(EA) ETH_ADDR_BYTES_ARGS((EA).ea)
#define ETH_ADDR_BYTES_ARGS(EAB) \
         (EAB)[0], (EAB)[1], (EAB)[2], (EAB)[3], (EAB)[4], (EAB)[5]

struct verify_hdr {
    __be16 eth_type;
    __be16 verify_rule;
    __be32 verify_port;
};

static inline bool eth_type_verify(__be16 ethertype)
{
    return (ethertype == htons(ETH_TYPE_PAZZ));
}

#endif  /* verify.h */
