#pragma once
#include <stdint.h>

inline double get_pos(double *matrix, uint32_t n, uint32_t i, uint32_t j)
{
    return matrix[i * n + j];
};