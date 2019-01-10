#!/bin/bash

# This script is used to generate a Makefile for compiling my blog

echo -e "BLOG_DIR=html

all: clean rss docs index

index:
\t\$(shell pandoc index.md -o index-temp.html)
\t\$(shell cat utils/header-index index-temp.html utils/footer-index > index.html)
\t\$(shell cat utils/footer-rss >> html/rss.xml)
\tmv index.html \$(BLOG_DIR)
\trm -f index-temp.html

upload:
\tscp html/rss.xml taha@tahaazzaoui.com:/var/www/html
\tscp -r \$(BLOG_DIR)/* taha@tahaazzaoui.com:/var/www/html/blog

rss:
\t\$(shell cat utils/header-rss > html/rss.xml)

clean:
\trm -f index.md html/*
" > Makefile

# Generate the rule to make all docs
echo -n "docs: " >> Makefile
for line in $(tac index.txt); 
do
    title=$(basename $line | cut -d. -f1)
    echo -n "$title " >> Makefile
done

echo -e "\n\n" >> Makefile

# Generate the rules for individual docs 
for line in $(tac index.txt); 
do
    title_no_ext=$(basename $line | cut -d. -f1)
    title_ext=$(basename $line)
    echo "$title_no_ext: src/$title_ext" >> Makefile
    echo -e "\t./md2html.sh $title_ext" >> Makefile
    echo -e "\tmv $title_no_ext.html \$(BLOG_DIR)\n" >> Makefile
done
