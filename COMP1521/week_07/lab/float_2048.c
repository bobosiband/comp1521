// Multiply a float by 2048 using bit operations only

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

#include "floats.h"

// float_2048 is given the bits of a float f as a uint32_t
// it uses bit operations and + to calculate f * 2048
// and returns the bits of this value as a uint32_t
//
// if the result is too large to be represented as a float +inf or -inf is returned
//
// if f is +0, -0, +inf or -inf, or Nan it is returned unchanged
//
// float_2048 assumes f is not a denormal number

float_components_t float_bits(uint32_t f) {
    // PUT YOUR CODE HERE
    float_components_t result;
    result.sign = (f >> 31) & 1;                   
    result.exponent = (f >> 23) & ((1 << 8) - 1);
    result.fraction = f & ((1 << 23) - 1);
    return result;
}

// given the 3 components of a float
// return 1 if it is NaN, 0 otherwise
int is_nan(float_components_t f) {
    // PUT YOUR CODE HERE

    return (f.exponent == 0xFF) && (f.fraction != 0);
}

// given the 3 components of a float
// return 1 if it is inf, 0 otherwise
int is_positive_infinity(float_components_t f) {
    // PUT YOUR CODE HERE

    return (f.sign == 0) && (f.exponent == 0xFF) && (f.fraction == 0);
}

// given the 3 components of a float
// return 1 if it is -inf, 0 otherwise
int is_negative_infinity(float_components_t f) {
    // PUT YOUR CODE HERE

    return (f.sign == 1) && (f.exponent == 0xFF) && (f.fraction == 0);
}

// given the 3 components of a float
// return 1 if it is 0 or -0, 0 otherwise
int is_zero(float_components_t f) {
    // PUT YOUR CODE HERE

    return (f.exponent == 0) && (f.fraction == 0);
}

//
uint32_t float_2048(uint32_t f) {
    float_components_t comp = float_bits(f);

    uint32_t all_ones_exp = (1 << 8) - 1; 
    //uint32_t zero_exp = 0;              

    if (is_nan(comp) || comp.exponent == all_ones_exp || is_zero(comp)) {
        return f;
    }

    uint32_t new_exp = comp.exponent + 11;


    if (new_exp >= all_ones_exp) {

        uint32_t result = (comp.sign << 31) | (all_ones_exp << 23);
        return result;
    }

    uint32_t result = (comp.sign << 31) | (new_exp << 23) | comp.fraction;
    return result;
}
