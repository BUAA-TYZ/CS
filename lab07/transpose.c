#include "transpose.h"

static int min(int x, int y) {
    if (x < y) {
        return x;
    }
    return y;
}

/* The naive transpose function as a reference. */
void transpose_naive(int n, int blocksize, int *dst, int *src) {
    for (int x = 0; x < n; x++) {
        for (int y = 0; y < n; y++) {
            dst[y + x * n] = src[x + y * n];
        }
    }
}

/* Implement cache blocking below. You should NOT assume that n is a
 * multiple of the block size. */
void transpose_blocking(int n, int blocksize, int *dst, int *src) {
    // YOUR CODE HERE
    int i, j, x, y;
    for (i = 0; i < n; i += blocksize) {
        for (j = 0; j < n; j += blocksize) {
            for (x = i; x < min(i + blocksize, n); x++) {
                for (y = j; y < min(j + blocksize, n); y++) {
                    dst[y + x * n] 
                    = src[x + y * n];
                }
            }
        }
    }
}
