---
author: Taha Azzaoui
date: 2018-10-07
title: A Blogging System in less than 100 lines of code 
categories:
  - web
---

### Background
I've been looking for some software to manage my blog, and while there exist some
popular options (WordPress, Jekyll, etc), I've found most of them to be incredibly 
bloated. For a while I just wrote out the HTML by hand, which was okay I guess,
but certainly not as efficient as I'd like. In particular, I found myself
spending more time tinkering with aesthetics than I did on writing the posts themselves.

### My Solution
The solution I came up with is satisfyingly simple, and plays out as follows. I
write my posts in Markdown (with vim of course). Markdown is incredibly easy to write in, it's
clear, concise, and pretty much the closest thing to plain text. It also handles
math via MathJax ($\frac{1}{ \sigma \sqrt{2 \pi}} e^{-\frac{{\left(\mu - x\right)}^{2}}{2 \, \sigma^{2}}}$).
Next, I use a
handy little utility called `pandoc` to convert the Markdown to HTML. `Pandoc`
itself is an indispensable tool written in Haskell. It's the Swiss-army knife of Markup
text. It handles HTML, Latex, Markdown, and can even convert files to pdf for presentation. 

Of course, it's annoying to compile each blog post individually, So I use a
Makefile to handle building the HTML files for me. The way this works is that I have a
script that queries a directory for all the Markdown files it contains, and
generates a Makefile containing the rules for building the resulting HTML. In
addition to building the HTML, the Makefile also generates a table of contents
from the title of each post along with an rss.xml that contains the contains
each blog post for reading with an RSS feeder. Once all is done, the Makefile
has an addition rule. `upload`, that directly publishes the content by shipping
the blog posts, table of contents, and the rss.xml to my remote server via
`scp`.

### The Simple Steps
1. Write a bunch of blog posts in markdown (in vim of course)
2. Run `./genmake.sh` in the same directory to automatically generate a Makefile
3. Run `make` to compile the Markdown into HTML and build the table of contents & rss.xml
4. Run `make upload` to upload the files to the web server

### Remarks
This is my system for now, and I'm pretty happy with it. It's nothing much,
which was my goal to begin with. In less than 100 lines of code, it can do exactly
what a blogging system should do- generate text. The system is freely available
and can be found here. Feel free to use it/repurpose it for your own needs.
