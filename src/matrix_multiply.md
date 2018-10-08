---
Author: Taha Azzaoui
Date: Oct 01, 2018
Title: Naive Matrix Products and the L1 Cache 
---

### Introduction

One of the most illustrative examples of the importance of data locality
arises in the implementation of matrix multiplication. This is because
the computation of the product of two matrices is inherently I/O bound
and therefore forces us to think about how best to access the elements
of each matrix.

![](images/matrix-multiply.png)

### Two Approaches

To start, let\'s consider two very similar naive implementations. Let A,
B, and C be n x n matrices

#### Implementation 1 (ijk)
```C
   for(int i = 0; i < n; ++i)  
      for(int j = 0; j < n; ++j)  
         for(int k = 0; k < n; ++k)
            C[i][j] += A[i][k] * B[k][j];  
```

#### Implementation 2 (ikj)
```C
   for(int i = 0; i < n; ++i)  
      for(int k = 0; k < n; ++k)  
         for(int j = 0; j < n; ++j)
            C[i][j] += A[i][k] * B[k][j];  
```

Where implementation 2 is the same as implementation 1 but with the
inner loop swapped with the second loop. Now let\'s compare the running
time of the two implementations with n = 1024.

          [taha@arch ~]$ time ./ijk
          ./ijk  11.95s user 0.01s system 99% cpu 12.017 total

          [taha@arch ~]$ time ./ikj
          ./ikj  4.00s user 0.00s system 99% cpu 4.005 total
          

On my machine, implementation 1 takes almost 3 times as long as
implementation 2! To see why, let\'s focus on the inner loop of each
one. Recall that C arranges its multidimensional arrays in row-major
order. That is, if A is a 3 x 3 matrix, it will be arranged in memory as
follows:

![](images/matrix-multiply-1.png)

The problem with implementation 1 is that matrix B is accessed
column-wise. On the first iteration, we access the element at
B\[0\]\[0\], at which point the processor loads a cache line from main
memory into the L1 cache. On the next iterations, we access B\[1\]\[0\],
B\[2\]\[0\], B\[3\]\[0\], etc, which, assuming a 64-byte cache line,
forces the processor to fetch another cache line from main memory every
time. In this implementation, only a single element is used from every
cache line loaded from memory, the rest are thrown away.

Compare this to implementation 2. The first iteration accesses
B\[0\]\[0\], for which the processor loads a cache line from main memory
into the L1 cache. Then, the following iterations access B\[0\]\[1\],
B\[0\]\[2\], B\[0\]\[3\], etc. Since these elements are all in the same
row, they\'ll also be in the same cache line. Therefore, every time a
memory access forces us to fetch a cache line from main memory, we get
the rest of the elements in the line for free. Clearly, this approach
makes much better use of the cache.

### Note

While multidimensional arrays are arranged in row-major order in C, some
languages, most notably Fortran, arrange matrices in column-major order.
As a general principle, memory should be accessed sequentially when
possible in order to make good use of the cache.

The source code for the two implementations can be found here:
[matrix-multiply.c](https://tahaazzaoui.com/uploads/matrix-multiply.c)
