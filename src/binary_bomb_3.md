---
Author: Taha Azzaoui
Date: December 26, 2017 
Title: The Binary Bomb Project: Part 3 
---

### Introduction

Okay, now things start to get interesting. Once again, let\'s run the
bomb inside of GDB and set a break point at `phase_3`. We can run the
program with our file of passwords and enter an arbitrary test string
when prompted for input. Once we reach the break-point, we can
disassemble `phase_3` and view the assembler dump as follows:


![](images/binary3_1.png)

### The Solution

Using the symbols as context clues again, we can decipher a call to the
C standard library function
[`sscanf`](http://www.cplusplus.com/reference/cstdio/sscanf/) at `+34`.
We know that this function takes in a C-string representing the format
of the user input to be read. This will tell us the type and number of
elements that make up this phase\'s password. Looking at `+20` we can
see that the contents of a hard-coded location in memory are being
pushed onto the stack. Let\'s inspect the contents of that location in
memory by running the following command:

![](images/binary3_2.png)

There\'s the format string! This tells us that the password consists of
two integers. Let\'s analyze the following code to learn more about the
properties of these two numbers. The instructions from `+39` to `+44`
check if the first integer is greater than 1, and set off the bomb if
not. Then the instruction at `+49` checks if the first integer is less
than 7 and sets off the bomb if it is not. We now have an upper and
lower bound on the first integer.

The instruction at `+58` uses the first integer to compute a byte offset
from the memory address `0x8049880`. We could inspect the contents of
this memory address, but it\'s trivial to see that the program is simply
using the first integer to index into some sort of jump table whose
values correspond to those on the odd lines from `+65` to `+119`.

The logic roughly translates to the following:

         int table[] = {0x10c, 0x20a, 0x258, 0x333, 0x231, 0x19b, 0x268, 0x73};
         if(numOne < 1 || numOne > 7 || numTwo != table[numOne])
            explode_bomb();

Concretely, if the first digit we enter is 5, the second digit must be
the sixth element in our table (zero indexing), namely 0x19b, or 411.

![](images/binary3_3.png)

Sure enough, our analysis is valid and this works. Moving swiftly along
to phase four!

[Click here for Phase IV](https://tahaazzaoui.com/blog/binary_bomb_4.html)
