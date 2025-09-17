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

static inline void print_vec(double *vec, size_t n)
{
    for (size_t i = 0; i < n; i++)
    {
        printf("%.1f, ", vec[i]);
    }
    printf("\n");
}

static inline void resolve_gauss_triangle(size_t n, size_t nrhs, double *a, double *b)
{
    size_t n_minus_1 = n - 1;

    double test[n];

    for (size_t row = 0; row < n; row++)
    {
        size_t inv_row = n_minus_1 - row;

        double denominator;
        double accumulator = 0;

        for (size_t col = 0; col < n; col++)
        {
            size_t inv_col = n_minus_1 - col;

            if (inv_col == inv_row)
            {
                printf("row(%d) col(%d)\n", inv_col, inv_row);
                denominator = a[get_pos_idx(n, inv_row, inv_col)];
            }
        }

        test[row] = denominator;
    }

    print_vec(test, n);
}