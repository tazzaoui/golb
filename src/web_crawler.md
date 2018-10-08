---
Author: Taha Azzaoui
Date: Jul 1, 2018 
Title: Writing a Web Crawler 
---

### The Internet as a Directed Graph

Before we dive into writing the crawler, we should develop a model for
viewing the web. Networks typically lend themselves well to analysis via
graph theory and the internet is no exception. In particular, we can
think of the internet as a directed graph where nodes correspond to web
pages and an edge from node X to node Y corresponds to a hyperlink on
page X linking to page Y. In this approach, one immediately notices
certain structural patterns embedded into the state of the internet. For
one, this graph is quite dense in some areas and quite sparse in others.
Sites that dominate the internet (e.g. Google, Facebook, Twitter,
Netflix, etc) will tend to have significantly more edges directed into
them as compared to smaller sites such as this one. Many see this as a
problematic point of centrality in what was supposed to be a
decentralized world wide web. Nevertheless, this idea will play a
significant role when it comes to ranking our search results.

### The Crawling Algorithm

The crawler starts by obtaining a list of the most popular websites on
the internet. For this, I used Amazon\'s list of the top 1 million sites
found [here](http://s3.amazonaws.com/alexa-static/top-1m.csv.zip). The
crawler starts by dividing the list evenly amongst the threads to be
spawned, at which point each thread loads its portion of the list into
its own queue. Once the queue has been populated with these initial
\"seed\" URLs, the crawler enters an infinite loop in which it performs
the following simple steps:

1.  Pop a URL out of the queue
2.  Send a request to the URL & retrieve its associated webpage
3.  Save the webpage to disk for future indexing
4.  Parse the webpage and extract the links it contains
5.  For each URL found, check if it has been seen before
    -   If not, add it to the queue
6.  Goto 1

### Implementation Details

After some thought about which programming language to use, I concluded
that the performance boost from using a compiled language would be
insignificant since the bottleneck here is network throughput. As such,
the main logic was written in Python with the critical sections of the
code executed through underlying libraries written in C. Furthermore,
since much of the execution time is spent waiting on network requests,
the crawler should be run on multiple threads in an effort to minimize
the CPU\'s idle time.

Aside from dissecting links, the crawler must also be able to keep track
of its previously visited URLs so as to avoid parsing duplicate
webpages. It turns out that an efficient data structure for this task is
the less well-known [Bloom
filter](https://en.wikipedia.org/wiki/Bloom_filter). The Bloom filter is
a probabilistic data structure that allows for set membership tests in
constant time. It does so using a bit vector along with a combination of
several hash functions. This constant time lookup became more important
as the list of URLs grew, since iterating through a list of millions of
URLs every time the crawler processed a link would have been
prohibitively expensive.

### Deployment

I set the crawler loose on a single node with 6 Cores, 8GB of RAM and
320GB of SSD. With this setup, I managed to retrieve north of 1.5
million web pages in about 48 hours. Now that we have our data, we can
begin writing the indexer.
