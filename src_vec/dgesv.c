#include "dgesv.h"

#include <math.h>

#include "utils/matrix_utils.h"

static const double EPSILON = 1e-10;

static void resolve_triangle_matrix(size_t n, size_t nrhs,
									double a[restrict n][n],
									double b[restrict n][nrhs]);

int my_dgesv(size_t n, size_t nrhs, double a[restrict n][n],
			 double b[restrict nrhs][nrhs])
{
#ifdef DEBUG
	printf("a -->\n");
	print_matrix((double *)a, n);
	printf("----\n");

	printf("b -->\n");
	print_vec((double *)b, n * nrhs);
#endif

	for (size_t col = 0; col < n; col++) {
#ifdef ROW_SWAPPING
		// Buscar pivote máximo en la columna
		size_t piv_row = col;
		double max_val = fabs(a[col][col]);
		for (size_t row = col + 1; row < n; row++) {
			double val = fabs(a[row][col]);
			if (val > max_val) {
				max_val = val;
				piv_row = row;
			}
		}

		// Intercambiar filas si es necesario
		if (piv_row != col) {
			for (size_t k = 0; k < n; k++) {
				double tmp = a[col][k];
				a[col][k] = a[piv_row][k];
				a[piv_row][k] = tmp;
			}

			// Intercambiar también B
			for (size_t j = 0; j < nrhs; j++) {
				double tmpb = b[col][j];
				b[col][j] = b[piv_row][j];
				b[piv_row][j] = tmpb;
			}
		}
#endif

		double piv1 = a[col][col];

		if (fabs(piv1) < EPSILON) {
			printf( "ERR: Almost null pivot in col %ld\n", col);
			return -1;
		}

		for (size_t row = col + 1; row < n; row++) {
			double piv2 = a[row][col];
			double mul = piv2 / piv1;

			// a
			for (size_t i = col; i < n; i++) a[row][i] -= mul * a[col][i];

			// b
			for (size_t j = 0; j < nrhs; j++) b[row][j] -= mul * b[col][j];
		}
	}

#ifdef DEBUG
	printf("nrhs(%zu)\n", nrhs);
	printf("a1 -->\n");
	print_matrix((double *)a, n);

	printf("b1 -->\n");
	for (size_t i = 0; i < nrhs; i++) print_vec(&b[0][i], n);
#endif

	resolve_triangle_matrix(n, nrhs, a, b);

#ifdef DEBUG
	printf("b2 -->\n");
	for (size_t i = 0; i < nrhs; i++) print_vec(&b[0][i], n);
#endif

	return 0;
}

static void resolve_triangle_matrix(size_t n, size_t nrhs,
									double a[restrict n][n],
									double b[restrict n][nrhs])
{
	size_t n_minus1 = n - 1;

	for (size_t i = 0; i < n; i++)	// Row+
	{
		size_t row = n_minus1 - i;

		double denominator = a[row][row];

		for (size_t rhs = 0; rhs < nrhs; rhs++) {
			double constant = 0.0;

			for (size_t j = 0; (j < n) && (j < i);
				 j++)  // Itera solo por los valores resueltos de la constante
			{
				size_t col = n_minus1 - j;

				double constant_mul = a[row][col];
				double constant_resolved = b[col][rhs];

				// Vectorization improvement attempt
				double multiplied = constant_mul * constant_resolved;
				constant = constant + multiplied;
			}

			b[row][rhs] = (b[row][rhs] - constant) / denominator;
		}

#ifdef DEBUG
		printf("[B] row(%zu) val(%.5f)\n", row, b[row][0]);
#endif
	}
}