#include "dgesv.h"
#include <matrix_utils.h>

static const double EPSILON = 1e-10;

int my_dgesv(int n, int nrhs, double *a, double *b)
{
	print_matrix(a, n);
	printf("----\n");

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

				for (size_t i = 0; i < n - col; i++)
				{
					size_t pos_i = pos + i;
					size_t top_i = col + i;

					a[pos_i] = (mul * a[pos_i]) + a[top_i];
				}
				b[row] = (mul * b[row]) + b[row];
			}
		}
	}

	print_matrix(a, n);

	double test[n * n];
	for (size_t i = 0; i < n * n; i++)
	{
		if (i % n == 0)
		{
			static size_t t = 0;

			test[i] = b[t++];
		}
	}

	printf("b->\n");
	print_matrix(test, n);

	// Resolver valores

	return 0;
}
