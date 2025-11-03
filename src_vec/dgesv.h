#pragma once

#include <stddef.h>

int my_dgesv(size_t n, size_t nrhs, double a[restrict n][n], double b[restrict nrhs][nrhs]);
