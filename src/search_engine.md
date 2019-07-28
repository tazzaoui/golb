---
author: Taha Azzaoui
date: 2018-06-27
title: Building a Search Engine 
categories:
    - web
    - information-retrieval
---

### Motivation

It's tough to imagine the internet without search engines. We've grown
accustomed to querying the massive set of data that is the web and
receiving pages of relevant results in a fraction of a second. As users
we expect our search engine to be fast, relevant, and easy to use. As
such, search engines present a set of interesting (and mostly solved)
challenges from algorithmic design to resource management. Ann Patterson
of Stanford does an excellent job describing a subset of them
[here](https://queue.acm.org/detail.cfm?id=988407).

### The Goal

In an effort to further investigate the nature of these challenges,
I've decided to write one myself. Now let me just say from the outset,
put aside all that you've come to expect from a commercial search
engine. This will be a modest system, capable of drawing from on the
order of a million pages (compared to the tens of billions of sites
crawled by Google). My goal is to get an idea of how search engines
generally work. I'll be documenting the interesting bits along the way
as I progress in what I predict to be a time consuming but worthy
endeavor

Before we begin, I strongly recommend reading the following sources as
they provide a good amount of background information.

1.  [The Anatomy of a Large-Scale Hypertextual Web Search
    Engine](http://infolab.stanford.edu/~backrub/google.html) \[Sergey
    Brin & Lawrence Page\]
2.  [Introduction to Information
    Retrieval](https://nlp.stanford.edu/IR-book/html/htmledition/irbook.html)
    \[Manning et al.\]
    -   Particularly the chapter on [Web Search
        Basics](https://nlp.stanford.edu/IR-book/html/htmledition/web-search-basics-1.html)

### The Components: A Quick Refresher

There are essentially four main phases in building a search engine.
I'll briefly describe them below, but we'll go into much more detail
later on.

1.  Crawling
    -   This is the "data collection" phase. The crawling algorithm is
        fairly straightforward. We start off with a set of "seed" URLs
        to visit. As we visit each seed, we extract the hyperlinks it
        contains and add them to the set of URLs we've yet to visit. We
        continue this recursive procedure, visiting the remaining links
        until we've reached our desired depth.
2.  Indexing
    -   This is where we store the data we've previously crawled in a
        way that makes it quick to retrieve. Look up speed is of
        paramount concern which means we'll need to choose our data
        structures wisely. We'll be implementing an [inverted
        index](https://en.wikipedia.org/wiki/Inverted_index) for our indexer..
3.  Ranking
    -   This part is arguably the most important part of the whole
        process, it's the secret sauce. It's what differentiates
        Google from Bing. Now that we can access the data we've
        retrieved, the question becomes how do we display it? Which
        result do we show first? How do we predict what the user wants
        to see? We'll be using a modified version of [Page
        Rank](https://en.wikipedia.org/wiki/PageRank) (Page as in Larry
        Page) as our ranking strategy.
4.  Query Serving
    -   This is mostly a distributed systems problem. Taking steps to
        ensure redundancy, using proper load balancing, minimizing
        download times, partitioning files, etc. However, since we're
        not writing the next big commercial search engine, I suspect
        this will be the area we focus on the least.

### Remarks

The code base for this project can be found
[here](https://github.com/tazzaoui/search). We'll be implementing the
logic purley from scratch, relying on external libraries only for
monotonous tasks such as parsing HTML.
