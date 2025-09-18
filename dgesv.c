#include "dgesv.h"
#include <matrix_utils.h>

static const double EPSILON = 1e-10;

int my_dgesv(int n, int nrhs, double *a, double *b)
{
	printf("a-->\n");
	print_matrix(a, n);
	printf("----\n");

	printf("b-->\n");
	print_vec(b, n);

	for (size_t col = 0; col < n; col++)
	{
		size_t piv1_i = get_pos_idx(n, col, col);
		double piv1 = a[piv1_i];

		for (size_t row = col + 1; row < n; row++)
		{
			if (a[get_pos_idx(n, row, col)] == 0.0)
				continue;

			double piv2 = a[get_pos_idx(n, row, col)];

			double mul = (piv2 / piv1);

			size_t pos_a1_idx = get_pos_idx(n, row, col);

			// a
			for (size_t i = 0; i < n - col; i++)
			{
				double result = mul * a[piv1_i + i];

				/*
				printf("[%.1f] -> (%.2f) - ", a[pos1_idx + i], -result);
				printf("[row(%d) col(%d) i(%d) mul(%.2f) piv1(%.2f) piv2(%.2f)]\n", row, col, i, mul, piv1, piv2);
				*/

				a[pos_a1_idx + i] -= result;
			}
			// b
			for (size_t j = 0; j < nrhs; j++)
			{
				size_t pos_b1_idx = j * n + row; // idx del row de b
				size_t pos_b2_idx = j * n + col; // idx del piv de b
				b[pos_b1_idx] -= mul * b[pos_b2_idx];
			}
		}
	}

	printf("nrhs(%d)", nrhs);
	printf("a1-->\n");
	print_matrix(a, n);

	printf("b1-->\n");
	for (size_t i = 0; i < nrhs; i++)
	{
		print_vec(&b[n * i], n);
	}

	resolve_triangle_matrix(n, nrhs, a, b);
	printf("b2-->\n");
	for (size_t i = 0; i < nrhs; i++)
	{
		print_vec(&b[n * i], n);
	}

	return 0;
}

int my_dgesv_old(int n, int nrhs, double *a, double *b)
{
	printf("a-->");
	print_matrix(a, n);
	printf("----\n");

	printf("b-->");
	print_vec(b, n);

	for (size_t i = 0; i < n; i++)
	{
		double v = a[i];
		if (v < 0) // abs(v)
			v = -v;

		if (v <= EPSILON)
			return -1;
	}

	// Dejar triangulo
	for (size_t col = 0; col < n; col++)
	{
		double top_val = a[col];

		for (size_t row = 0; row < n; row++)
		{
			if (row > col)
			{
				size_t pos = get_pos_idx(n, row, col);
				double pos_val = a[pos];

				double mul = -(top_val / pos_val);
				printf("\nMul(%lf)\n", mul);

				for (size_t i = 0; i < n - col; i++)
				{
					size_t pos_i = pos + i;
					size_t top_i = col + i;

					a[pos_i] = (mul * a[pos_i]) + a[top_i];
				}
				b[row] = (mul * b[row]) + b[row]; // TODO: nrhs
			}
		}
	}

	printf("a1-->\n");
	print_matrix(a, n);

	printf("b1->\n");
	print_vec(b, n);

	resolve_triangle_matrix(n, nrhs, a, b);

	printf("res(b)->\n");
	print_vec(b, n);

	return 0;
}
