#include "dgesv.h"
#include <matrix_utils.h>
#include <math.h>

static const double EPSILON = 1e-10;

int my_dgesv(size_t n, size_t nrhs, double *a, double *b)
{
#ifdef DEBUG
	printf("a-->\n");
	print_matrix(a, n);
	printf("----\n");

	printf("b-->\n");
	print_vec(b, n);
#endif

	for (size_t col = 0; col < n; col++)
	{
#ifdef ROW_SWAPPING
		// Buscar pivote máximo en la columna
		size_t piv_row = col;
		double max_val = fabs(a[m_idx(n, col, col)]);
		for (size_t row = col + 1; row < n; row++)
		{
			double val = fabs(a[m_idx(n, row, col)]);
			if (val > max_val)
			{
				max_val = val;
				piv_row = row;
			}
		}

		// Intercambiar filas si es necesario
		if (piv_row != col)
		{
			for (size_t k = 0; k < n; k++)
			{
				double tmp = a[m_idx(n, col, k)];
				a[m_idx(n, col, k)] = a[m_idx(n, piv_row, k)];
				a[m_idx(n, piv_row, k)] = tmp;
			}

			// Intercambiar también B
			for (size_t j = 0; j < nrhs; j++)
			{
				double tmpb = b[col * nrhs + j];
				b[col * nrhs + j] = b[piv_row * nrhs + j];
				b[piv_row * nrhs + j] = tmpb;
			}
		}
#endif

		size_t piv1_i = m_idx(n, col, col);
		double piv1 = a[piv1_i];

		if (fabs(piv1) < EPSILON)
		{
			fprintf(stderr, "ERR: Almost null pivot in col %ld\n", col);
			return -1;
		}

		for (size_t row = col + 1; row < n; row++)
		{
			double piv2 = a[m_idx(n, row, col)];

			double mul = (piv2 / piv1);

			size_t pos_a1_idx = m_idx(n, row, col);

			// a
			for (size_t i = 0; i < n - col; i++)
			{
				double result = mul * a[piv1_i + i];
				a[pos_a1_idx + i] -= result;
			}
			// b
			for (size_t j = 0; j < nrhs; j++)
			{
				size_t pos_b1_idx = row * nrhs + j; // idx del row de b
				size_t pos_b2_idx = col * nrhs + j; // idx del piv de b
				b[pos_b1_idx] -= mul * b[pos_b2_idx];
			}
		}
	}

#ifdef DEBUG
	printf("nrhs(%d)", nrhs);
	printf("a1-->\n");
	print_matrix(a, n);

	printf("b1-->\n");
	for (size_t i = 0; i < nrhs; i++)
	{
		print_vec(&b[n * i], n);
	}

#endif

	resolve_triangle_matrix(n, nrhs, a, b);

#ifdef DEBUG
	printf("b2-->\n");
	for (size_t i = 0; i < nrhs; i++)
	{
		print_vec(&b[n * i], n);
	}
#endif

	return 0;
}
