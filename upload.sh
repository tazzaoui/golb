#!/bin/bash
SITE=/home/taha/Code/azzaoui.org

./golb.py
mv html/rss.xml $SITE
mv html/* $SITE/blog
cd $SITE
git add .
git commit
git push
