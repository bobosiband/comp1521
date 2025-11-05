// generate the encoded binary for an addi instruction, including opcode and operands

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

#include "addi.h"

// return the encoded binary MIPS for addi $t,$s, i
uint32_t addi(int t, int s, int i) {
    uint32_t instruction = 0;
    uint32_t bit_set = 1;
    uint32_t reg_inst = s;

    instruction |= bit_set << 29;
    instruction |= reg_inst << 21;
    reg_inst = t;
    instruction |= reg_inst << 16;
    // reg_inst = i;
    // 001000 sssss ttttt (iiii iiii iiii iiii)
    uint16_t inst = i;
    instruction |= inst;


    return instruction; // REPLACE WITH YOUR CODE

}
