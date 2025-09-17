#include "dgesv.h"
#include <matrix_utils.h>

int my_dgesv(int n, int nrhs, double *a, double *b)
{
	print_matrix(a, n);
	printf("---\n\n");

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

				for (size_t i = 0; i < n; i++)
				{
					//TODO: resultado de la linea
				}

				a[pos] = (mul * a[pos]) + a[col]; // Eso por pos
			}
		}
	}

	print_matrix(a, n);

	return 0;
}
