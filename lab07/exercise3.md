#### Part 1
- blocksize = 20, n = 100: 0.003/0.005
- blocksize = 20, n = 1000: 2.226/1.905
- blocksize = 20, n = 2000: 17.054/7.625
- blocksize = 20, n = 5000: 259.245/56.417
- blocksize = 20, n = 10000: 1766.24/340.968

    Checkoff Question 1: n = 1000
    Checkoff Question 2: When n is small, the whole matrix can be cached, so blocked version is no need.

Part 2
- blocksize = 50, n = 10000: 1839.68/256.327
- blocksize = 100, n = 10000: 2028.38/183.422
- blocksize = 500, n = 10000: 1887.58/115.918
- blocksize = 1000, n = 10000: 2172.82/138.392
- blocksize = 5000, n = 10000: 1609.7/1299.4

    Checkoff Question 3: Because the block size is bigger than the cache size.
