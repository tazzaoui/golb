---
author: Taha Azzaoui
date: 2017-12-27
title: The Binary Bomb Project- Part 4 
categories:
    - reverse-engineering
    - assembly
---


### Introduction

Okay, by now we've established a routine. Let's run the bomb inside of
GDB and set a break point at `phase_4`. We can run the program with our
file of passwords and enter an arbitrary test string when prompted for
input. Once we reach the breakpoint, we can disassemble `phase_4` and
view the assembler dump as follows:

![](/images/binary4_1.png)

### The Solution

Once again, we see the call to
[`sscanf`](http://www.cplusplus.com/reference/cstdio/sscanf/) at `+27`,
so by the same reasoning from phase 3, we know we should be looking for
a format string of some sort. This will tell us the type and number of
elements that make up this phase's password. Looking at `+13` we can
see that the contents of a hardcoded location in memory are being pushed
onto the stack. Let's inspect the contents of that location in memory
by running the following command:

![](/images/binary4_2.png)

There's the format string! This tells us that the password consists of
a single integer. Let's analyze the following code to learn more about
the properties of this number. The interesting bit is at `+51` where our
input is being pushed onto the stack followed by a call to the function
`func4`. After `func4` returns, the program is checking to make sure our
input has turned into the value 0x961 (2401 in decimal). Our next course
of action is to determine the behavior of `func4` and apply it inversely
to the value 2041. Let's analyze `func4` to learn more about what it
does to our input.

![](/images/binary4_3.png)

An initial scan through the function results in indentifying the
instruction at `+24` as being a recursive one, this is obviously the
case as the function is calling itself. As such, every recursive
function generally constists of a combination of two components: a base
case and a recursive case.

Let's start by identifying the base case at `+14` where the function
tests for the zero flag being set therby returning, if the value stored
in `edx` is equal to zero. According to the instruction at `+6`, our
input is being stored in the register `edx` Otherwise, it goes on to
subtract 1 from the value and calls the itself with the new value. So we
have a natural lower bound of 0 on our integer. Note that on `+9` the
program stores the value of 1 into `eax`, which remains unchanged untill
we reach `+38`, at which point `+36` and `+38` implement the following
logic: `eax` = `edx` - `eax`.

The final step in determining the return value of `func4`, is to
determine the behavior of `edx`. Some knowledge about the load effective
address (`leal`) instruction is required at this point. In general, the
instruction `leal a(%eax, %edx, b), %ecx` results in the operation:
`%ecx = %eax + b * %edx + a`. Therefore, we can express the instruction
at `+29` as: `%edx = 8 * %eax`. The first time the function runs, it
will set `%eax` to 1, multiply it by 8, then subtract 1. The next time
it runs it will multiply %eax now 7, by 8 then subtract 7, yeilding 49.
The pattern now becomes clear. The function is iteratively raising 7 to
whatever number the user provides as input.

We can encode everything we've learned so far into the following
equation: $2041 = 7^x$ where $x$ is our input. Taking the base-7 logarithm
of both sides, we see that our input must be 4.

![](/images/binary4_4.png)

Sure enough our password is correct and with that we're one step closer
to completion.
