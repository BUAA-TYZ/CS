#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "lfsr.h"

unsigned get_bit(uint16_t x,
                 unsigned n) {
    return (x >> n) & 1;
}
void set_bit(uint16_t * x,
             unsigned n,
             unsigned v) {
    // YOUR CODE HERE
    if (v == 1) {
        *x |= (1 << n);
    } else {
        *x &= ~(1 << n);
    }
}

void lfsr_calculate(uint16_t *reg) {
    /* YOUR CODE HERE */
    unsigned t = get_bit(*reg, 0) ^ get_bit(*reg, 2) 
    ^ get_bit(*reg, 3) ^ get_bit(*reg, 5);
    *reg >>= 1;
    set_bit(reg, 15, t);
}

