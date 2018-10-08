---
Author: Taha Azzaoui
Date: December 24, 2017 
Title: The Binary Bomb Project: Part 1 
---

### Introduction

Now that we\'ve set up our work space, and gotten acquainted with our
toolbox, it\'s time to embark on our journey.

We begin by turning to objdump to disassemble our binary into its
original assembly. Note that the command `objdump -d ./bomb > ouput.txt`
will place the resulting assembly into a file by the name of
`output.txt`.

Using the symbols as a guide, our initial analysis leads us to the
function `phase_1`.

![](images/binary1_1.png){.articleImage}

### The Solution 

Phase one is fairly straight forward. We can tell from the assembly that
the bomb is comparing user input against a predetermined string, and
blowing up if the two strings are unequal. The important part is on the
fourth line, where the operand of the `movl` instruction is the memory
address containing the predetermined string. We turn to GDB to view the
contents of memory at that address.

After starting the bomb inside of GDB, we can set a break-point at
`phase_1` using the command `break phase_1`. We then run the program,
entering an arbitrary test string when prompted for input. Once we reach
the break-point, we can execute the command `disas` to view the
instruction next up for execution. Note that the memory address of
interest is at `+6`. We view the string at this location as follows.

![](images/binary1_2.png){.articleImage}

Et voila! The string is right there in plain sight. Phase one is now
complete. Let\'s move on to phase two, where things start to become
nontrivial.

[Sidenote: the string we found is a quote attributed to former
Vice-President Dan Quayle](http://www.phrases.org.uk/meanings/397100.html)

[Click here for Phase II](https://tahaazzaoui.com/blog/binary_bomb_2.html)
