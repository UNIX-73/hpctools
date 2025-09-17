#pragma once
#include <stdio.h>
#include <stddef.h>

static inline size_t get_pos_idx(size_t n, size_t row, size_t col)
{
    return row * n + col;
}

static inline void mul_row(double *row, size_t n, double mul)
{
    for (size_t i = 0; i < n; i++)
    {
        row[i] = row[i] * mul;
    }
}

static inline void print_matrix(double *matrix, size_t n)
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