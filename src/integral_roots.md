---
Author: Taha Azzaoui
Date: April 20, 2018 
Title: Integral roots of univariate polynomials
---

![](images/hilbert.jpg)

### Brief Introduction

Lecturing before the International Congress of Mathematicians in 1900,
the great David Hilbert presented the world with a list of 23 unsolved
mathematical conundrums, which in his expert opinion, were worthy of
pursuit. The tenth among them seeks the derivation of a method which,
given any finite polynomial with integer coefficients, can decide if
said polynomial has integral roots (roots belonging to the set of
integers). As an example, \$f(x,y,z) = x + y\^2 + z\^3\$ has an integral
root at \$(-31, 2, 3)\$ but \$g(x) = x\^2 - 2\$ has no integral roots
(since \$\\sqrt{2} \\notin \\mathbb{Z}\$).

To quote Hilbert, problem ten roughly translates from his native German
to the following: "Given a Diophantine equation with any number of
unknown quantities and with rational integral numerical coefficients: To
devise a process according to which it can be determined in a finite
number of operations whether the equation is solvable in rational
integers." For now, think of a Diophantine equation as essentially a
polynomial. We will define it more rigorously soon enough.

Such an algorithm was though to exist (as implied by Hilbert\'s
question) until Yuri Vladimirovich Matiyasevich et al. eloquently proved
otherwise. For the sake of intuition, before we get into Matiyasevich\'s
insight and the computability of Diophantine sets, let\'s consider the
familiar case of finite polynomials with integer coefficients over only
one variable, and show that there does exist an algorithm for
determining their integral roots.

### A plausible solution

Since the integers are countable, our first approach in devising an
algorithm would be to evaluate the polynomial at \$\\pm i\$ for all \$i
\\in \\mathbb{N}\$ and simply halt once we find a root. However,
consider the case of a polynomial with no integral roots. It\'s clear
that the algorithm will run forever, unless we can come up with some
tight bound on the roots, outside of which we are certain no roots
exist.

### Bounding the roots

Consider the finite polynomial with integer coefficients of order n\...
\$\$f(x) = c\_0 + c\_1x + c\_2x\^2 + c\_3x\^3 + \... + c\_nx\^n\$\$
Suppose \$r\$ is a root of the polynomial\... \$\$0 = c\_0 + c\_1r +
c\_2r\^2 + c\_3r\^3 + \... + c\_nr\^n \$\$ We can rearrange the terms
and yield\... \$\$-(c\_0 + c\_1r + c\_2r\^2 + c\_3r\^3 + \... +
c\_{n-1}r\^{n-1}) = c\_nr\^n\$\$ We can then take the absolute value of
both sides\... \$\$\|c\_0 + c\_1r + c\_2r\^2 + c\_3r\^3 + \... +
c\_{n-1}r\^{n-1}\| = \|c\_nr\^n\|\$\$ We then apply the triangle
inequality\... \$\$\|c\_0\| + \|c\_1r\| + \|c\_2r\^2\| + \|c\_3r\^3\| +
\... + \|c\_{n-1}r\^{n-1}\| \\geq \|c\_nr\^n\|\$\$ Denote the
coefficient with the largest magnitude by \$c\_m\$. The inequality still
holds if we substitute it in place of the remaining coefficients\...
\$\$\|c\_m\|(1 + \|r\| + \|r\^2\| + \|r\^3\| + \... + \|r\^{n-1}\|)
\\geq \|c\_nr\^n\|\$\$ Note: \$(1 + \|r\| + \|r\^2\| + \|r\^3\| + \... +
\|r\^{n-1}\|) \\leq \\sum\_{i = 0}\^{n} \|r\^{n - 1}\| = n\|r\^{n -
1}\|\$ Therefore\... \$\$\|c\_m\| \|r\^{n - 1}\|n \\geq \|c\_nr\^n\|
\\implies \\frac{\|c\_m\|}{\|c\_n\|}n \\geq \|r\|\$\$ In other words,
the integral roots of the polynomial must lie within the interval
\$\[-\\frac{c\_m}{c\_n}n, \\frac{c\_m}{c\_n}n\]\$. Where \$c\_m\$ is the
coefficient with the largest magnitude, \$c\_n\$ is the coefficient of
the highest order term, and \$n\$ is the order of the polynomial.

### Exhaustive but finite

Now that we have a tight bound on the roots of the polynomial, we can
devise an algorithm whose running time is finite. We proceed the same as
before, except we now evaluate the polynomial at every integer within
the range \$\[-\\frac{c\_m}{c\_n}n, \\frac{c\_m}{c\_n}n\]\$. We simply
return true if the function evaluates to \$0\$ and false if the last
value in the set is reached and no such root was found. Below is python
script that implements this exhaustive search.

    """
    Reads in a set of n coefficients {c_0, c_1, ..., c_n} as
    command line arguments such that f(x) = sum(c_i * x^i)
    as a command line arguments and attempts to find
    the integral roots of the polynomial they represent.
    """

    import sys
    import math

    def f(coefs, x):
        """
        Evaluates f(x) given a 
        set of coefficients
        and an input x.
        """
        res = 0
        for i in range(len(coefs)):
            res += coefs[i] * x**i
        return res

    # input: {c_0, c_1, ..., c_n} s.t. f(x) = sum(c_i * x^i)
    coefs = [int(i) for i in sys.argv[1:]]

    # Order of the polynomial
    order = len(coefs) - 1

    # Coefficient with the largest magnitude
    c0 = max([abs(i) for i in coefs])

    # Cofficient of the highest order term
    c1 = coefs[order]

    # +- bound on possible values for the roots of f(x)
    bound = math.ceil(order*c0/c1)

    # set of all possible values for the roots of f(x)
    values = list(range(-1 * bound, bound))

    root = None
    for val in values:
        print("f({}) = {}".format(val, f(coefs,val)))
        if f(coefs, val) == 0:
            print("Found integral root! x = {}".format(val))
            root = val
    if root == None:
        print("No integral roots found!")
