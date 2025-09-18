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
            printf("%.2f, ", matrix[get_pos_idx(n, row, col)]);
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

        double denominator = a[get_pos_idx(n, row, row)];
        double constant = 0.0;

        for (size_t j = 0; (j < n) && (j < i); j++) // Itera solo por los valores resueltos de la constante
        {
            size_t col = n_minus1 - j;

            double constant_mul = a[get_pos_idx(n, row, col)];
            double constant_resolved = b[col];
            constant += constant_mul * constant_resolved;
        }

        b[row] = (b[row] - constant) / denominator;

        printf("[B] row(%d) val(%.5f) const(%.3f) \n", row, b[row], constant);
    }
}

static inline void old_resolve_triangle_matrix(size_t n, size_t nrhs, double *a, double *b)
{
    size_t n_minus_1 = n - 1;
    double test[n];

    for (size_t i = 0; i < n; i++)
    {
        size_t row = n_minus_1 - i;

        double denominator;
        double accumulator = 0.0;
        double constant = b[row];

        // Saca el accumulator y denominator
        for (size_t j = 0; ((j < n) && (j <= i)); j++)
        {
            size_t col = n_minus_1 - j;
            size_t pos_idx = get_pos_idx(n, row, col);

            if (col == row)
            {
                denominator = a[pos_idx];
            }
            else
            {
                double multiplier = a[pos_idx];
                double resolved = b[col + 1]; // No debería llegar aqui en el primer iter del row porque !(col <= row)
                accumulator += multiplier * resolved;
            }
        }

        b[row] = (-accumulator + constant) / denominator;

        test[row] = denominator;
    }

    // print_vec(test, n);
}