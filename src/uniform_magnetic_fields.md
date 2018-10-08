---
Author: Taha Azzaoui
Date: Jul 07, 2018 
Title: Uniform Magnetic Fields 
---

### Introduction

A [Helmholtz coil](https://en.wikipedia.org/wiki/Helmholtz_coil) is a
circular apparatus used to produce an approximately uniform magnetic
field. For this reason, it is ideal for studying the behavior of objects
under the influence of a uniform magnetic field. In what follows, we
will make use of symmetry to derive the expression for the magnetic
field between two Helmholtz coils.

![Figure 1: The magnetic field along the axis of a single current loop
of radius R.](images/mfahc-1.jpg){.center}

Recall that magnetic fields ascribe to every point in space a vector
that describes the magnetic influence of an electric current on an
object at that point. The value of the magnetic field at an
infinitesimally small point in space is defined according to the
[Biot-Savart](https://en.wikipedia.org/wiki/Biot%E2%80%93Savart_law) law
\$\$d\\vec{B} = \\frac{\\mu\_0}{4 \\pi} \\frac{Id\\vec{l} \\times
\\hat{r}}{r\^2} \\tag{1}\$\$ In the case of the loop in Figure 1, the
vectors \$d\\vec{l}\$ and \$d\\vec{r}\$ are perpendicular, therefore we
have \$\$d\\vec{B} = \\frac{\\mu\_0}{4 \\pi} \\frac{I}{r\^2} dl
\\tag{2}\$\$ We can then integrate over the entire loop to find the
cummulative field \$\$\\vec{B} = \\frac{I\\mu\_0}{4 \\pi} \\oint
\\frac{1}{r\^2} dl \\tag{3}\$\$ Note that by the symmetry of the loop,
we can ignore the planar components of the magnetic field. To see this,
recall that we are looking for the magnetic field through the exact
center of loop. This means that, for every point on the loop \$p\_1\$,
there must exist another point \$p\_2\$ on the opposite side of the loop
such that magnetic field at \$p\_1\$ is equal in magnitude to that at
\$p\_2\$ (since they\'re equidistant from the center) but opposite in
direction (since \$d\\vec{l}\$ is tangent to the loop). Therefore, we
are only interested in the z-component of the field. \$\$dB\_z =
dBcos\\theta = dB\\frac{R}{r} = \\frac{\\mu\_0}{4 \\pi} \\frac{IR}{r\^3}
dl \\tag{4}\$\$

![Figure 2: Planar components of \$\\vec{B}\$ cancel due to the symmetry
of the loop.](images/mfahc-2.jpg){.center}

Finally, we can integrate this value along the loop. Note that by the
Pythagorean theorem, we have \$r = \\sqrt{R\^2 + z\^2}\$.
\$\$\\begin{eqnarray} B &=& \\int cos\\theta dB\\nonumber \\\\ &=&
\\int\_0\^{2\\pi R} \\frac{\\mu\_0}{4 \\pi} \\frac{IR}{r\^3} dl
\\nonumber \\\\ &=& \\frac{IR\\mu\_0}{4 \\pi (R\^2 + z\^2)\^{3/2}}
\\int\_0\^{2\\pi R} dl \\nonumber \\\\ &=& \\frac{IR\^2\\mu\_0}{2 (R\^2
+ z\^2)\^{3/2}} \\nonumber \\end{eqnarray}\$\$ Our resulting equation
for the magnetic field along the axis of a charged loop is \$\$\\vec{B}
= \\frac{IR\^2\\mu\_0}{2 (R\^2 + z\^2)\^{3/2}} \\hat{k} \\tag{5}\$\$

In the case of two Helmholtz coils with \$N\$ turns each, separated by a
distance \$h\$, with one coil centered at the origin, we have
\$\$\\vec{B}\_H = \\frac{NIR\^2\\mu\_0}{2 (R\^2 + z\^2)\^{3/2}}\\hat{k}
+ \\frac{NIR\^2\\mu\_0}{2 (R\^2 + (h-z)\^2)\^{3/2}} \\hat{k}
\\tag{6}\$\$ We can find a relative optimum in the magnetic field by
differentiating \$B\$ and setting the result to \$0\$.
\$\$\\frac{\\partial \\vec{B}}{\\partial z} = 0 \\implies z =
\\frac{h}{2} \\tag{7}\$\$ Using (7), we can calculate the corresponding
spacing between the coils \$\$\\frac{\\partial \\vec{B}\|\_{z =
h/2}}{\\partial h} = 0 \\implies h = R \\tag{8}\$\$ Substituting (7) and
(8) into (6), we can obtain the magnetic field under the optimal values
of \$z\$ and \$h\$. Finally, we can substitute (7) and (8) into (6) to
obtain the expression of the magnetic field under the optimal values of
\$z\$ and \$h\$. \$\$B\_H = \\frac{8\\mu\_0 NI}{\\sqrt{125}R} \\hat{k}
\\tag{9}\$\$
