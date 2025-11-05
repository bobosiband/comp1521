// swap pairs of bits of a 64-bit value, using bitwise operators

#include <assert.h>
#include <stdint.h>
#include <stdlib.h>

// return value with pairs of bits swapped
uint64_t bit_swap(uint64_t value) {
    // PUT YOUR CODE HERE
    const uint64_t even_mask = 0xAAAAAAAAAAAAAAAAULL;
    const uint64_t odd_mask  = 0x5555555555555555ULL;
    return ((value & even_mask) >> 1) | ((value & odd_mask) << 1);
}
