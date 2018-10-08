---
Author: Taha Azzaoui
Date: Aug 01, 2018 
Title: Writing an Indexer
---

### Introduction

Now that we\'ve obtained a set of documents using our
[crawler](crawler.html), it\'s time to think about information
extraction. Consider once more the search process. The user first enters
a query, then the engine is to take that query and apply some
preprocessing, after which it is to somehow cross-reference the terms in
the query against the terms in the corpus. The (extremely) naive
approach for cross-referencing would be to preform a linear search of
the query terms across every document in the corpus. This approach
suffices for a small set of documents, but obviously becomes
prohibitively expensive at scale.

### Inverted Index

In a plain index, the general approach is to map each document to the
set of terms that it contains. That is, for each document in our corpus,
we end up with a list of the unique terms it consists of. However, this
clearly isn\'t too useful in the context of a search engine as we still
have to iterate through each document in the index to check for our
search term. It turns out that by simply inverting this model, we can
trade its linear look up time with a constant lookup time. That is,
rather than mapping documents to the words that they contain, we can
instead map words to the documents that contain them. This makes it so
that, given a search term, we can instantly obtain the set of documents
in which it occurs without incurring the hefty cost associated with
iterating through the corpus. As an example, consider the following set
of documents.

1.  NASA found water on Mars
2.  Flowing water found on Mars
3.  Underground lake of water found on Mars

If we were to represent the corpus using an index, we would have

-   1 \$\\rightarrow\$ \[NASA, found, water, on, Mars\]
-   2 \$\\rightarrow\$ \[Flowing, water, found, on Mars\]
-   3 \$\\rightarrow\$ \[Underground, lake, of, water, found, on, Mars\]

On the other hand, if we were to use inverted index we would have

-   NASA \$\\rightarrow\$ \[1\]
-   found \$\\rightarrow\$ \[1, 2, 3\]
-   water \$\\rightarrow\$ \[1,2,3\]
-   on \$\\rightarrow\$ \[1,2,3\]
-   Mars \$\\rightarrow\$ \[1,2,3\]
-   Flowing \$\\rightarrow\$ \[2\]
-   Underground \$\\rightarrow\$ \[3\]
-   lake \$\\rightarrow\$ \[3\]
-   of \$\\rightarrow\$ \[3\]

Now consider searching for the word \"water\". Under the index model, we
would first check for \"water\" in document 1, in which case it exists,
then check for it in document 2 in which case it also exists, and
similarly for document 3 until finally we can conclude that \"water\"
appears in documents 1, 2, and 3. Under the inverted index model
however, we simply look up the list associated with \"water\" and
immediately see that it can be found in documents 1, 2, 3. Same result
in a fraction of the time.

### Building the Inverted Index

Before building the inverted index, we need to obtain a set of tokens
from each document and apply some preprocessing which will help in later
ranking our results. The general steps we\'ll take are as follows.

1.  Strip out any unnecessary information. This includes any JavaScript,
    CSS, comments, etc
2.  Construct a list of the unique tokens on the page
3.  Convert every token to lowercase
4.  Stem each token to reduce the word down to its root form. This
    allows us to treat words with the same stem as synonyms. For
    example, the terms \"walking\", \"walked\", and \"walks\" all refer
    to the word \"walk\".
5.  Remove any stop words from the list. These are words that don\'t
    contain much information about the content. Words including \"the\",
    \"is\", \"a\", \"at\", etc

Additionally, it is helpful to store the number of occurrences of a
given token within each document. This will be of use in determining the
tf-idf weight of a term during the ranking process (more on this later).

The resulting data structure for each token will be a list of pairs
where each pair represents a document in which the token exists. The
first element of each pair will be an integer representing the number of
times the token appears in the document, and the second element will be
the string representation of the base16 encoded URL of the web page. To
keep it simple, we will use python\'s
[pickle](https://docs.python.org/3/library/pickle.html) library to write
each list to a file under the base16 encoding of the token.

### Remarks

The indexer\'s source code can be found
[here](https://github.com/tazzaoui/search/tree/master/indexer). Our next
course of action is to begin ranking the results of a search. This step
is much less straight forward than crawling and indexing but it is far
more important.
