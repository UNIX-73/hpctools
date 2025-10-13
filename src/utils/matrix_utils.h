#pragma once
#include <stdio.h>
#include <stddef.h>
#include <stdbool.h>
#include <math.h>
#include <stdint.h>

static inline size_t m_idx(size_t n, size_t row, size_t col)
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
            printf("%.2f, ", matrix[m_idx(n, row, col)]);
        }
        printf("\n");
    }
}

static inline void print_vec(double *vec, size_t n)
{
    for (size_t i = 0; i < n; i++)
    {
        printf("%.9f, ", vec[i]);
    }
    printf("\n");
}

static inline void resolve_triangle_matrix(size_t n, size_t nrhs, double *a, double *b)
{
    size_t n_minus1 = n - 1;

    for (size_t i = 0; i < n; i++) // Row+
    {
        size_t row = n_minus1 - i;

        double denominator = a[m_idx(n, row, row)];

        for (size_t rhs = 0; rhs < nrhs; rhs++)
        {
            double constant = 0.0;

            for (size_t j = 0; (j < n) && (j < i); j++) // Itera solo por los valores resueltos de la constante
            {
                size_t col = n_minus1 - j;

                double constant_mul = a[m_idx(n, row, col)];
                double constant_resolved = b[m_idx(nrhs, col, rhs)];
                constant += constant_mul * constant_resolved;
            }

            b[m_idx(nrhs, row, rhs)] = (b[m_idx(nrhs, row, rhs)] - constant) / denominator;
        }

#ifdef DEBUG
        printf("[B] row(%d) val(%.5f)  \n", row, b[row]);
#endif
    }
}

static inline uint32_t compare_results_divergence(size_t n, double *m1, double *m2)
{

    for (double power = 0.0; power <= 19; power++)
    {
        double diff = pow(10.0, -((double)power));

        for (size_t i = 0; i < n; i++)
        {
            for (size_t j = 0; j < n; j++)
            {
                double v = m1[m_idx(n, i, j)] - m2[m_idx(n, i, j)];

                if (fabs(v) > diff)
                {
                    printf("The result differs by at least 10^e-%f\n", power);
                    return 1;
                }
            }
        }
    }
    return 0;
}
