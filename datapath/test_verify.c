#include <stdio.h>
#include <stdbool.h>

#include "verify.h"

void dump_ptr(char *ptr, int len)
{
    int i;
    for (i = 0; i < len; i++) {
        printf("%02x", ptr[i]);
        if (i % 4 == 3)
            printf(" ");
    }
    printf("\n");
}

int main(int argc, char *argv[])
{
    struct ovs_action_verify_port verify_port;
    struct ovs_action_verify_rule verify_rule;

    uint64_t dpid;
    uint32_t base, bloom, item;
    uint16_t base16, item16;

    memset(&verify_port, 0, sizeof(struct ovs_action_verify_port));
    memset(&verify_rule, 0, sizeof(struct ovs_action_verify_rule));

    while (true) {
        printf("dpid (hex): ");
        scanf("%lx", &dpid);
        printf("base (hex): ");
        scanf("%x", &base);
        printf("new (port/rule): ");
        scanf("%d", &item);

        base16 = (uint16_t)base;
        item16 = (uint16_t)item;

        verify_port.port = item;
        verify_port.dpid = dpid;
        verify_rule.rule = item16;
        verify_rule.dpid = dpid;

        bloom = base;
        bloom_add(&bloom, &verify_port, sizeof(struct ovs_action_verify_port) - 4);

        printf("[DUMP]\n\tport (%ld bytes): ", offsetof(struct ovs_action_verify_port, port));
        dump_ptr((char *)&verify_port, sizeof(uint64_t) + sizeof(uint32_t));
        printf("\n\trule (%ld bytes): ", offsetof(struct ovs_action_verify_rule, rule));
        dump_ptr((char *)&verify_rule, sizeof(uint64_t) + sizeof(uint16_t));
        printf("\n");

        printf("%#x + %d at %#lx:\n\tcrc16: %#x\n\tbloom: %#x\n",
                base, item, dpid,
                crc16_verify(&verify_rule, sizeof(struct ovs_action_verify_rule) - 6, base16),
                bloom);
        fflush(stdout);
    }
}
