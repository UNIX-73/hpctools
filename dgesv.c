#include "dgesv.h"
#include <matrix_utils.h>

int my_dgesv(int n, int nrhs, double *a, double *b)
{
	int i = 0;

	for (uint32_t row = 0; row < n; row++)
	{
		for (uint32_t col = 0; col < row; col++)
		{
			size_t pos = get_pos_idx(n, row, col);

			a[pos] = i--;
		}
	}

	print_matrix(a, n);

	return 0;
}
