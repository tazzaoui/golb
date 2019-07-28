---
author: Taha Azzaoui
date: 2017-12-25
title: The Binary Bomb Project- Part 2 
categories:
    - reverse-engineering
    - assembly
---

### Introduction

We begin by noting that one can avoid tediously entering the password
for each preceding phase, by placing each password on a separate line in
a txt file and invoking the bomb with the path to that file as a command
line argument.

Let's fire up the bomb inside of GDB and set a break point at
`phase_2`. We can run the program with our file of passwords and enter
an arbitrary test string when prompted for input. Similar to our method
of approach in phase one, we can then run `disas` once we reach the
break-point to view the next instruction up for execution.

![](/images/binary2_1.png)

### The Solution

The symbol `read_six_numbers` is a dead giveaway. It's probably not too
much of a stretch to assume that this function\...well\...reads six
numbers! After reading six numbers, the function enters some type of
loop which starts by storing the first number we entered in the register
`eax` at `+32`, then adds 5 to it at `+35` and compares that sum to the
value of the next number entered at `+38`. The bomb explodes if these
two numbers are not equal. Otherwise, it jumps to the update section of
the loop at `+47` where it queues up the next element in our input list
and uses it to repeat the same tests.

This roughly translates to the following:

~~~c
for(int i = 0; i < 6; ++i)
  if(input[i] + 5 != input[i + 1])
    explode_bomb();
~~~

Let's test this out by entering the sequence *5 10 15 20 25 30* as
our input. Sure enough this solution works, and with that we're on to
phase three!

[Click here for Phase III](https://azzaoui.org/blog/binary_bomb_3.html)
