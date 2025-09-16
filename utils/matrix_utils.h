#pragma once
#include <stdint.h>
#include <stdio.h>

static inline size_t get_pos_idx(uint32_t n, uint32_t row, uint32_t col)
{
    return row * n + col;
}

static inline void print_matrix(double *matrix, uint32_t n)
{
    for (size_t row = 0; row < n; row++)
    {
        for (size_t col = 0; col < n; col++)
        {
            printf("%.1f, ", matrix[get_pos_idx(n, row, col)]);
        }
        printf("\n");
    }
}