---
Author: Taha Azzaoui
Date: Jul 04, 2018 
Title: Electric Forces and Fields 
---

### The Electric Force

We understand by means of experimentation that two point charges
separated by a distance \$r\$ exhibit a force proportional to the
inverse of \$r\^2\$. More specifically, according to Coulomb\'s law, we
can express this electric force as \$\$\\boldsymbol{F}\_{e} =
\\frac{1}{4\\pi\\epsilon\_{0}} \\frac{q\_1 q\_2}{r\^2} \\hat{r}
\\tag{1}\$\$ Where \$\\epsilon\_{0}\$ is the permittivity of free space
and \$q\_i\$ is the charge contained by the \$i\^{\\text{th}}\$ point
charge. Note that \$\\boldsymbol{F\_e}\$ is negative when the charges
differ in sign and positive otherwise. This coincides with the intuitive
notion that opposites attract.

### The Conservative Nature of the Electric Force

It is important to note that the electric force is a conservative one.
This is a consequence of the fact that the work done by the electric
force along a path that starts and ends at the same point is identically
zero. To see this, recall the equation for the work done by a force
\$\$W = \\oint\_l \\boldsymbol{F} \\cdot d\\boldsymbol{l} \\tag{2}\$\$
If we substitute the electric force from (1) into (2) and express
\$d\\boldsymbol{l}\$ in spherical coordinates, we get the following
\$\$\\begin{eqnarray} W &=& \\oint\_s \\frac{1}{4\\pi\\epsilon\_{0}}
\\frac{q\_1 q\_2}{r\^2} \\hat{r} \\cdot (d\\boldsymbol{r}\\hat{r} +
rd\\boldsymbol{\\theta}\\hat{\\theta} + rsin\\theta
d\\boldsymbol{\\phi}\\hat{\\phi}) \\nonumber \\\\ &=&
\\frac{q\_1q\_2}{4\\pi\\epsilon\_{0}} \\int \\frac{1}{r\^2} dr
\\nonumber \\tag{3} \\end{eqnarray}\$\$ Finally, we evaluate the
resulting integral along a closed path that starts and ends at the same
point \$p\$. \$\$\\frac{q\_1q\_2}{4\\pi\\epsilon\_{0}} \\int\_p\^p
\\frac{1}{r\^2} dr = \\frac{-q\_1q\_2}{2\\pi\\epsilon\_{0}}
\\frac{1}{r\^3} \\Bigr\|\_{p}\^{p} = 0 \\tag{4}\$\$ Therefore, we have
shown that the work done by the electric force along a path that starts
and ends at the same point is identically 0, which implies that the
electric force is conservative.

### The Electric Field

With a non-contact force such as the electric force, it can be difficult
to visualize the effect of a point charge (or a collection of them) on
its surroundings. Consequently, we introduce the concept of an electric
field, a vector quantity which we define to be the electric force per
unit charge at every point in space. In other words, if a probe charge
\$q\_0\$ experiences a force \$\\boldsymbol{F\_e}\$ at some point in
space \$(x, y, z)\$, then the electric field at that location is
\$\$\\boldsymbol{E}(x, y, z) = \\frac{\\boldsymbol{F\_e}}{q\_0}
\\tag{5}\$\$ Note that we now have a new way of expressing the electric
force \$\$\\boldsymbol{F\_e}= \\boldsymbol{E} q\_0 \\tag{6}\$\$

### Electric Potential Energy

Another way of visualizing the effects of charge on its surroundings is
via the scalar potential. It follows from the conservative nature of the
electric force that there must exist some potential energy function
\$U\$ associated with it. Furthermore, by the work-energy theorem, the
net decrease in potential energy must be equivalent to the work done by
the electric force. \$\$dU = - \\boldsymbol{F\_e} \\cdot
d\\boldsymbol{s} \\tag{7}\$\$ Similar to the way we defined the electric
field, we now introduce a new quantity, the electric potential
difference, which we define to be the change in potential energy per
unit charge. \$\$dV = \\frac{dU}{q\_0} \\tag{8}\$\$ One may be
suspicious of the significance of equations (7) and (8). These equations
are useful in that they allow us to describe properties of the electric
field without dealing with the underlying vector calculus. Therefore, we
now have two ways of describing the electric field- the first is using
the definition of the electric field itself (equation 5) and the second
is using the electric potential difference (equation 8). We now describe
the relationship between these two methods and demonstrate how to go
back and forth between them. We start by rewriting equation (7) using
equation (6) \$\$dU = - \\boldsymbol{E} q\_0 \\cdot d\\boldsymbol{s}
\\tag{9}\$\$ Next, we substitute this equation into (8) \$\$dV =
-\\boldsymbol{E} \\cdot d\\boldsymbol{s} \\tag{10}\$\$ We can express
this equation in component form \$\$\\begin{eqnarray} dV &=&
-(E\_x\\hat{i} + E\_y\\hat{j} + E\_z\\hat{k}) \\cdot (dx\\hat{i} +
dy\\hat{j} + dz\\hat{k}) \\nonumber \\\\ &=& -(E\_x dx + E\_y dy +
E\_zdz) \\nonumber \\tag{11} \\end{eqnarray}\$\$ This relationship
implies \$\$\\begin{eqnarray} \\boldsymbol{E} &=&
-(\\frac{\\partial{V}}{\\partial{x}}\\hat{i} +
\\frac{\\partial{V}}{\\partial{y}}\\hat{j} +
\\frac{\\partial{V}}{\\partial{z}}\\hat{k}) \\nonumber \\\\ &=&
-(\\frac{\\partial}{\\partial{x}}\\hat{i} +
\\frac{\\partial}{\\partial{y}}\\hat{j} +
\\frac{\\partial}{\\partial{z}}\\hat{k})V \\nonumber \\\\ &=& - \\nabla
V \\nonumber \\tag{12} \\end{eqnarray}\$\$ In other words, the electric
field has magnitude equal to the rate of change of the electric
potential and points in the direction of maximum potential decrease.
