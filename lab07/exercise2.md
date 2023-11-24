1. jki kji
2. ikj kij

---



--- lines below are ignored by the AG ---

#### Checkoff Question 1

- For jki: In 3rd loop, A, B and C hit the cache. In 2nd loop, C and B hit the cache.
- For kji: In 3rd loop, A, B and C hit the cache. In 2nd loop, A hit the cache.  

#### Checkoff Question 2

- For ikj: In 3rd loop, B miss the cache. In 2nd loop, A miss the cache.
- For kij: In 3rd loop, C and B miss the cache. 

#### Checkoff Question 3

C[i + j * n] += A[i + k * n] * B[k + j * n]

- To improve the performance, we need to utilize the cache as most as possible, which requires us to put i as the index of the 3rd loop.
- For the 2nd loop, using j or k has no effect for A and B. But for C, we should use k.
- So the most performant solution is jki.
- Same reason for the worst one.