---
author: Taha Azzaoui
date: 2018-02-16
title: Euler's Method 
categories:
    - differential-equations
    - numerical-methods
---

###  "Euler's Method? bUt ThAt'S aNcIeNt!" 

I recently saw the movie *Hidden Figures* in which there was a scene where a group of mathematicians are trying to calculate the trajectory of a capsule. 
As the group is stuck brainstorming, Katherine Johnson heroically exclaims that their problem can be solved using Euler's method. 
The scene can be seen [here](https://www.youtube.com/watch?v=v-pbGAts_Fg). 
Now, the scene is obviously yet another example of Hollywood dramatizing mathematics, as it's hard to believe that an elite group of mathematicians employed by NASA
would have overlooked a solution as trivial as Euler's method. In any event, this post seeks to outline the method in all of its simplicity.

### Introduction 

In any introductory course on the theory of ordinary differential
equations, a significant amount of time is dedicated to the study of a
special class of first order differential equations for which there
exists an analytic method of solving. These include a subset of the
separable equations, linear equations, exact equations, etc. However, as
it turns out, a vast majority of differential equations do not have an
analytic solution. So what happens when we encounter a differential
equation that cannot be solved analytically? Well, we can either (a)
pack up our bags and head home or (b) look for a method that yields an
approximation which we consider to be "good enough" for the
application to any real world problem. For those interested in option b,
the field of [Numerical Analysis](https://en.wikipedia.org/wiki/Numerical_analysis) has proven
to be incredibly useful in the field of engineering. Below is a
description of a simple method for numerically integrating differential
equations which was presented by [Leonhard
Euler](https://en.wikipedia.org/wiki/Leonhard_Euler) in the 18th
century.

### The Problem

Suppose we have the first order ODE: $\frac{dy}{dx} = f(x,y)$ with
some known initial value $y(x_0) = y_0$. We assume the necessary
conditions for the [existence of a unique
solution](http://faculty.sfasu.edu/judsontw/ode/html/firstlook06.html),
namely that $f$ and $f_y$ are continuous.

### What we know

1.  The value of the function at $x_0$
2.  The derivative of the function at $x_0$, $\frac{dy}{dx}|_{x = x_0}$
3.  Putting the two together, we also know the equation of the line
    tangent to the solution curve at $x_0$. i.e. $y = y_0 + f(x_0,
    y_0) (x - x_0)$

### The Tangent Line Approximation

Observe the following figure. In the red is the graph of $f(x) = x^2$
and in the blue is the line tangent to $f(x)$, call it $g(x)$ at the
point $x = 1$. Note that $f(1) = g(1)$, by the definition of a
tangent line. However, a more interesting property of the tangent line
arises in the context of values near $x = 1$. It turns out, as you can
probably convince yourself from the figure below, that for the values of
$x$ proximal to the point of tangency, the values of $g(x)$ are
approximately equal to the values of $f(x)$. Stated more formally, let
$x_0$ be the point of tangency and let $0 < \varepsilon < 1.$
Then... $$g(x') \approx f(x') \text{ } \forall \text{ } x'
\in [x_0 - \varepsilon, x_0 + \varepsilon]$$ Moreover..
$$\lim_{\varepsilon\to0} \frac{f(x_0)}{g(x_0 + \epsilon)} =
1$$ i.e. The smaller the $\varepsilon$, the more accurate the
approximation

![](/images/euler-ode_1.png)

### The Method

Using the tangent line, we now have a function that takes a point on the
solution curve $(x_0,y_0)$ and the derivative at that point, and
returns a nearby point on the solution curve, namely $(x_0 +
\varepsilon, y_1)$. Now that we have an approximate nearby solution,
the question then remains: how do we approximate the solution for values
farther away from the point of tangency? As evident by the figure above,
the tangent line is not a very good estimator of values far from the
point of tangency.

The trick is to take an iterative approach. We start by using the
initial conditions $(x_0,y_0)$ to approximate a nearby point on the
solution curve, namely $(x_0 + \varepsilon, y_1)$. The crucial step
is to note that if $y_1$ is a good approximation of the actual
solution curve at $x = x_0 + \varepsilon$, then we can use it to
form another line tangent to $f(x)$ at the point $x_0 +
\varepsilon$. We then use this new tangent line to approximate the
value of the solution curve nearby the new point of tangency, namely
$(x_0 + 2\varepsilon, y_2)$. We continue this process of using the
previous step's estimate to make a new estimate for as many steps as we
see fit. We call $varepsilon$ our step size. After running the
algorithm, we end up with the following set of points...
$$\{(x_0,y_0),(x_0 + \varepsilon, y_1), (x_0 + 2\varepsilon,
y_2)...(x_0 + n\varepsilon, y_n)\}$$ Where $n$ is the number
of iterations. We can then plot the solution curve by connecting these points.

![](/images/euler-ode_2.png)

We can apply Euler's method to our example, $\frac{dy}{dx} = x^2$,
letting $\varepsilon = 0.1$ for $n = 50$ steps. In the figure
above, the orange points are found via Euler's method and the black
curve is the actual solution, namely $y = \frac{1}{3}x^3$
(surprise!). Note the similarity between the two sets of values.

Below is a snippet of python code that implements Euler's method, the
full code is available [here](https://github.com/tazzaoui/Numerical-ODE-Examples).

~~~python
'''
Euler's Numerical Integration Method
  
x0: Initial x-value 
y0: Initial y-value
epsilon: Step Size
n: Number Of Steps
'''

def euler(f,x0,y0,epsilon,n):
  x = x0
  y = y0
  for i in range(n):
    print "({},{})".format(x,y)
    y += epsilon * f(x, y)
    x += epsilon
    return y

# Example function f(x) = x^2
def f(x,y):
  return x*x

x0 = y0 = 0
epsilon = 0.1
n = 50
euler(f,x0,y0,epsilon,n)
~~~
### Remarks

While Euler's method is useful for approximating values of trivial ODEs
like the one above, it is not considered to be sufficiently accurate.
This is due to the fact that as the number of steps increases, error
begins to accumulate and the estimates tend to diverge from the actual
value. See [here](http://www.math.unl.edu/~gledder1/Math447/EulerError)
for a complete discussion on the shortcomings of Euler's method. That
being said, Euler's method is still desirable in light of its
simplicity and has been used as a basis for more complicated numerical
integration techniques including that of
[Heun](https://en.wikipedia.org/wiki/Heun%27s_method).
