---
Author: Taha Azzaoui
Date: Dec 20, 2017 
Title: Gradient Descent 
---

### Note
The following is not meant to be a [rigorous
proof](http://www.stat.cmu.edu/~ryantibs/convexopt-F13/scribes/lec6.pdf)
of the ideas behind Gradient Descent. Rather it\'s aim is to use
fundamental ideas in Calculus to provide an intuitive understanding of
what the algorithm claims, and why it makes the assumptions that it
does.

### Introduction

The goal of optimization problems can be simple to state, yet sometimes
nontrivial to achieve. Given a cost function \$f : A \\rightarrow R\$,
we generally seek some value \$x\^{\*} \\epsilon A\$ which satisfies the
constraint \$f(x\^\*) \\leq f(x)\$ \$\\forall\_{x \\epsilon A}\$. Note
that we limit the conversation to cost functions which are strictly
convex in order to defer the problem of local minima.

### Intuition

There are many algorithms for optimizing the value of a function,
perhaps the most intuitive of which is the iterative method of Gradient
Descent.The idea is simple, and can be illustrated by the following
scenario. Suppose you are standing on some mountainous convex region
well above sea level. Furthermore, suppose you wish to *descend* upon
the lowest point in said region in the shortest amount of time. How
would you go about accomplishing such a goal? One way to go about it is
to turn 360 degrees and ask yourself the following question: *\"Which
direction points the most downwards?\"* Then take a step in that
direction, and repeat until you find yourself at the lowest point in the
region.

This is where the gradient comes in. Given a vector \$\\vec{v}\$ and a
vector-valued function \$F\$ (differentiable around \$\\vec{v})\$, the
direction of maximum decrease in \$F\$ is that opposite to the gradient
of \$F\$ evaluated at \$\\vec{v}\$, or \$- \\nabla F(\\vec{v})\$. In
other words, the largest decrease in \$F\$ relative to \$\\vec{v}\$ is
some scalar multiple \$\\alpha\$, along \$-\\nabla F(\\vec{v})\$.

### Why does this work?

Recall that in two-dimensional Euclidean space, the optimization of a
differentiable function \$f(x)\$ results in the search space:
\$\\{\\alpha \\epsilon \\mathbb{R} : \\frac{df}{dx}\|\_{\\alpha} =
0\\}\$. Where we define the derivative of a function as
\$\$\\frac{df}{dx} = \\lim\_{\\Delta x\\to\\infty} \\frac{f(x + \\Delta
x) - f(x)}{\\Delta x}\$\$ This definition works well in two dimensions,
where there are only two possible directions from which \$\\Delta x\$
can approach \$\\infty\$, namely the from left and the right (recall
that the function must approach the same value from both sides for the
limit to exist). This idea of a limit holds in multiple dimensions as
well, however we face a much stronger set of conditions. Not only must
we verify that the function is approaching the same value from the left
and right, we must go a step further and verify that it approaches the
same value [irrespective]{.underline} of the direction of approach. This
presents a problem as there exist an infinite number of directions from
which to approach a value in multi-dimensional space.

As such, the concept of a \"derivative\" becomes much less strictly
defined. We can specify a direction and define the **directional
derivative** of a function \$g : A \\rightarrow \\mathbb{R}\^{n}\$ in
the direction of some unit vector \$\\vec{v} \\epsilon A\$ as the value
\$\\nabla\_{\\vec{v}} g = \\nabla g \\cdot \\vec{v}\$. Intuitively, the
directional derivative determines the rate of change of \$g\$ along the
direction of \$\\vec{v}.\$ Now we can rephrase our initial question.
*\"Which direction points the most downwards?\"* translates to *\"For
what value of \$\\vec{v}\$ is the directional derivative minimized?\"*
In other words, we seek a vector \$\\vec{v} \\epsilon A\$ that satisfies
the constraint \$\\nabla\_{\\vec{v}} g \\leq \\nabla\_{\\vec{x}} g\$
\$\\forall\_{\\vec{x} \\epsilon A}.\$

By the definitions of the directional derivative and the dot product, we
have: \$\$\\nabla\_{\\vec{v}} g = \\nabla g \\cdot \\vec{v} = \|\\nabla
g\| \|\\vec{v}\| cos\\theta = \|\\nabla g\| cos\\theta\$\$ (since
\$\\vec{v}\$ is a unit vector). Since the gradient term is fixed,
minimizing the value of \$cos\\theta\$ is sufficient for minimizing the
expression itself. This is obviously the case when \$cos\\theta = -1\$
or \$\\theta = \\pi\$, which implies that \$\\vec{v}\$ must have the
same magnitude but point in the opposite direction of \$\\nabla g\$.

Therefore \$\\vec{v} = -\\nabla g\$ must satisfy our constraint. {#therefore-vecv--nabla-g-must-satisfy-our-constraint. align="center" style="font-size:105%"}
================================================================

### Convergence

Gradient Descent uses this concept iteratively, by starting out with an
arbitrary initial value for the parameters of the cost function and
incrementally updating each parameter along the direction of steepest
descent. In doing so, Gradient Descent aims to get closer to a minima
after every iteration until eventually
[converging](https://www.cs.cmu.edu/~ggordon/10725-F12/slides/05-gd-revisited.pdf)
after a finite number of steps.

Convergence here can be application specific. In general, we can run the
algorithm for a pre-determined number of iterations (on the order of
\$10\^3\$), or we can declare convergence if the incremental update for
a given iteration is less than some \$\\varepsilon = 10\^{-3}\$.
