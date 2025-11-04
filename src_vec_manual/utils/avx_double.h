#pragma once

#include <immintrin.h>

#define VEC_ALIGN __attribute__((aligned(VEC_BYTES)))

#if defined(__AVX512F__)

typedef __m512d double_vec;
#define VEC_DOUBLE_LEN 8
#define VEC_BYTES 64
#define VEC_NAME "AVX-512"

#define vec_loadu(p) _mm512_loadu_pd(p)
#define vec_storeu(p, v) _mm512_storeu_pd(p, v)
#define vec_set1(x) _mm512_set1_pd(x)

#define vec_add(a, b) _mm512_add_pd(a, b)
#define vec_sub(a, b) _mm512_sub_pd(a, b)
#define vec_mul(a, b) _mm512_mul_pd(a, b)
#define vec_div(a, b) _mm512_div_pd(a, b)
#define vec_fmadd(a, b, c) _mm512_fmadd_pd(a, b, c)

#elif defined(__AVX2__)

typedef __m256d double_vec;
#define VEC_DOUBLE_LEN 4
#define VEC_BYTES 32
#define VEC_NAME "AVX2"

#define vec_loadu(p) _mm256_loadu_pd(p)
#define vec_storeu(p, v) _mm256_storeu_pd(p, v)
#define vec_set1(x) _mm256_set1_pd(x)

#define vec_add(a, b) _mm256_add_pd(a, b)
#define vec_sub(a, b) _mm256_sub_pd(a, b)
#define vec_mul(a, b) _mm256_mul_pd(a, b)
#define vec_div(a, b) _mm256_div_pd(a, b)
#define vec_fmadd(a, b, c) _mm256_fmadd_pd(a, b, c)

#elif defined(__SSE2__)

typedef __m128d double_vec;
#define VEC_DOUBLE_LEN 2
#define VEC_BYTES 16
#define VEC_NAME "SSE2"

#define vec_loadu(p) _mm_loadu_pd(p)
#define vec_storeu(p, v) _mm_storeu_pd(p, v)
#define vec_set1(x) _mm_set1_pd(x)

#define vec_add(a, b) _mm_add_pd(a, b)
#define vec_sub(a, b) _mm_sub_pd(a, b)
#define vec_mul(a, b) _mm_mul_pd(a, b)
#define vec_div(a, b) _mm_div_pd(a, b)
#define vec_fmadd(a, b, c) _mm_add_pd(_mm_mul_pd(a, b), c)

#else

typedef double double_vec;
#define VEC_DOUBLE_LEN 1
#define VEC_BYTES 8
#define VEC_NAME "SCALAR"

#define vec_loadu(p) (*(p))
#define vec_storeu(p, v) (*(p) = (v))
#define vec_set1(x) (x)

#define vec_add(a, b) ((a) + (b))
#define vec_sub(a, b) ((a) - (b))
#define vec_mul(a, b) ((a) * (b))
#define vec_div(a, b) ((a) / (b))
#define vec_fmadd(a, b, c) ((a) * (b) + (c))

#endif
