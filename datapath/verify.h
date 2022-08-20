#ifndef VERIFY_H
#define VERIFY_H 1

/* PAZZ */

#include <linux/if_ether.h>
#include <linux/netdevice.h>

/* comment out for debug mode */
#if 0
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <stdint.h>
#include <stddef.h>
#include <arpa/inet.h>
struct ovs_action_verify_port {
    uint64_t dpid;
    uint32_t port;
};

struct ovs_action_verify_rule {
    uint64_t dpid;
    uint16_t rule;
};
#endif

//#define PAZZ_DEBUG

#define VERIFY_HLEN         8
#define ETH_TYPE_PAZZ       0x820
#define TUN_AS_VERIFY

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

/* CRC16 */
unsigned short crc16_ccitt(const void *buf, int len);
unsigned short crc16_verify(const void *buf, int len, unsigned short basis);

/* BLOOM */
//void bloom_free(uint32_t filter);
void bloom_add(uint32_t *filter, const void *p, size_t n);
void bloom_add_32bit(uint32_t *filter, uint32_t item);

#endif  /* verify.h */
