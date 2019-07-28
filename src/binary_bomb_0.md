---
author: Taha Azzaoui
date: 2017-12-20
title: The Binary Bomb Project- Part 0 
categories:
    - reverse-engineering
    - assembly
---

First, a quick note to the NSA agent reading this web-page after it has
been flagged by a web crawler: the phrase "The Binary Bomb Project"
explicitly refers to the innocent programming exercise described below
and nothing else. Great, now that that's out of the way, let's get
started

### Introduction

The art of reverse engineering is a useful one indeed, applicable to the
defense against malicious (proprietary) software, the ability to better
understand the behavior of one's own programs, the ability to identify
potential optimizations, and much more. In general, a better
understanding of the underlying behavior of software can lead to
significant improvements in correctness and performance. For these
reasons and more, the binary bomb project is a virtuous exercise in
identifying assembly-level patterns in code.

### Important Note:

The program is compiled into the IA-32 instruction set, which makes a
32-bit architecture necessary for running the bomb. In the likely lack
of access to a 32-bit processor, one can run the bomb within a virtual
machine. I suggest installing a [32-bit Ubuntu
image](https://www.ubuntu.com/download/alternative-downloads) using
[Oracle\'s Virtual-Box](https://www.virtualbox.org/wiki/Downloads).

### How it works

The idea is simple, the bomb is the resulting binary of an intentionally
obfuscated program originally written in C. It consists of a sequence of
six phases, each of which expects the input of a specific string via
`stdin`. If the string is correct, the phase is then "defused", at
which point we are allowed to move on to the next phase. Otherwise, the
bomb "explodes" by outputting "BOOM!!!" to `stdout`. Every time the
bomb explodes, we must restart from the initial phase. The goal of
course, is to get through all 6 phases without an explosion.

### Our toolbox

A list of the tools along with resources that explain their use can be
found below. It is helpful but not necessary to be an expert in using
these tools, as their use cases extend far beyond this project. However,
a basic familiarity of their most common commands/options is sufficient
in this case.

[List of the the general GNU binary utilities](https://ftp.gnu.org/old-gnu/Manuals/binutils-2.12/html_node/binutils.html)

#### The Subset of tools we will make use of

1.  [The GNU Debugger (GDB)](https://www.gnu.org/software/gdb/)
2.  [ObjDump](https://ftp.gnu.org/old-gnu/Manuals/binutils-2.12/html_node/binutils_6.html)
3.  [Strings](https://ftp.gnu.org/old-gnu/Manuals/binutils-2.12/html_node/binutils_9.html#SEC9)

[Click here for Phase I](https://azzaoui.org/blog/binary_bomb_1.html)
