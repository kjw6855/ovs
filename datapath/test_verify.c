#include <stdio.h>
#include <stdbool.h>

#include "verify.h"

int main(int argc, char *argv[])
{
    uint32_t base, bloom, item;
    uint16_t base16, item16;

    while (true) {
        printf("base (hex): ");
        scanf("%x", &base);
        printf("new (dec): ");
        scanf("%d", &item);

        base16 = (uint16_t)base;
        item16 = (uint16_t)item;

        bloom = base;
        bloom_add(&bloom, item);
        printf("%#x + %d:\n\tcrc16: %#x\n\tbloom: %#x\n",
                base, item,
                crc16_verify((const void *)&item, 2, base16),
                bloom);
    }
}
