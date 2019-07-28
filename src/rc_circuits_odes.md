---
author: Taha Azzaoui
date: 2018-07-10
title: RC Circuits - An Application of ODEs 
categories:
    - physics
    - differential-equations
---

### Parallel Plate Capacitors

Often times we wish to store electrical energy for later use. To do so,
we can use a parallel plate capacitor, an electrical component which
stores potential energy in the form of an electric field. If we connect
a battery to both plates of the capacitor, the battery will transport
charge from one plate to the other until the potential difference within
the plates is equivalent to that of the battery. To analyze the behavior
of capacitors, we use the quantity of capacitance, which is defined as
the ratio of the magnitude of the charge on each plate, Q, and the
potential difference across the plates $\Delta V_c$. That is, $$C
= \frac{Q}{\Delta V_c} \tag{1}$$ Note that the SI unit of
capacitance is Coulombs per volt, otherwise known as a Farad.

### The RC Circuit

An RC (short for resistor-capacitor) circuit is an aptly named circuit
consisting of a resistor of resistance $R$, a capacitor of capacitance
$C$, and a battery of electromotive force $\varepsilon$. Let $Q$
be the magnitude of the charge on the capacitor and let $I$ be the
magnitude of the current flowing through the circuit. Note that these
two quantities are related by $$I = \frac{dQ}{dt} \tag{2}$$

### Capacitor Charging

When the voltage source (in this case a battery) is connected to the
circuit, the current flowing through the circuit will serve to charge
the capacitor until its potential difference is equivalent to that of
the battery. According to Kirchhoff's second law, we much have
$\sum_{i = 1}^{n}V_i = 0$. We can express the potential difference
across the capacitor in terms of capacitance using (1), $V_c =
\frac{Q}{C}$. Finally, we'll assume that the potential difference
across the battery is equivalent to its electromotive force. Putting all
this together, we get the following first order linear differential
equation. $$R\frac{dQ}{dt} = \frac{Q}{C} - \varepsilon = 0
\nonumber \tag{3}$$ The equation here is separable, and can be
solved trivially as follows $$\begin{eqnarray} \frac{dQ}{dt} +
\frac{1}{RC}Q - \frac{1}{RC} \varepsilon = 0 \nonumber\\\\
\frac{dQ}{dt} = \frac{Q - \varepsilon C}{-RC} \nonumber \\\\ \int
\frac{1}{Q - \varepsilon C} dQ = \frac{-1}{RC} \int dt \nonumber
\\\\ ln \| Q - \varepsilon C\| = \frac{-t}{RC} + K \nonumber \\\\ Q -
\varepsilon C = e^{\frac{-t}{RC}}e^{K} \nonumber \\\\ Q =
\varepsilon C + e^{\frac{-t}{RC}} e^{K} \nonumber \\\\ Q(0) =
\varepsilon C + e^{K} = 0 \implies e^K = - \varepsilon C \nonumber
\\\\ Q = \varepsilon C - \varepsilon C e^{-t}{RC} \nonumber \end{eqnarray}$$

Therefore, we have $$Q(t) = \varepsilon C(1 - e^{-t}{RC})
\tag{4}$$ Note that $$\lim_{t\to\infty} Q(t) = \varepsilon
C$$ Which is exactly what we would expect given the definition of
capacitance in (1).

### Capacitor Discharging

We now turn to what happens when the voltage source is disconnected from
the circuit. Our equation is the same as before, save for the
electromotive force which has now disappeared. $$R \frac{dQ}{dt} +
\frac{Q}{C} = 0 \nonumber \tag{5}$$ 

$$\begin{eqnarray} \frac{dQ}{dt} + \frac{1}{RC}Q = 0 \nonumber \\\\\int \frac{1}{Q} dQ = \frac{-1}{RC} \int dt \nonumber \\\\ ln \|Q\| = \frac{-t}{RC} + K \nonumber \\\\Q = e^{-t}{RC}e^{K} \nonumber \\\\\text{Note: } Q(0) = e^0e^K \implies Q_0 = e^{K} \nonumber \\\\ \end{eqnarray}$$ 

Therefore, we have our desired result: $$Q(t) = Q_0e^{\frac{-t}{RC}} \tag{6}$$
