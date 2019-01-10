#!/bin/bash

# This script is used to turn a markdown blog post into an html file
blog_title=$(grep "Title: *" src/$1 | cut -f2- -d " ")
escaped_title=$(echo $blog_title | sed -e 's/ /_/g') 
blog_date="$(date --date="$(grep "Date: *" src/$1 | cut -f2- -d " ")")"
brief_date="$(date --date="$blog_date" +%m.%d.%y)"
blog_page=$(echo "$1" | cut -d'.' -f1).html
blog_page_tmp=$(echo "$1" | cut -d'.' -f1)-temp.html

pandoc --ascii -t html5 src/$1 -o $blog_page_tmp
cat utils/header $blog_page_tmp utils/footer > $blog_page

# Replace the title
sed -i -e 's/TITLE-HERE/'"$blog_title"'/g' $blog_page

# Replace the date
sed -i -e 's/DATE-HERE/'"$blog_date"'/g' $blog_page

# Replace the link
sed -i -e 's/HTML-FILE-HERE/'"$blog_page"'/g' $blog_page

# Replace the post identifier in the feedback form 
sed -i -e 's/POST-HERE/'"$escaped_title"'/g' $blog_page

# Clean the html
tidy -q -i -m -w 120 -ashtml -utf8 --tidy-mark no $blog_page

# Last post of 2017
if [ "$blog_title" == "Plato and Justice as Human Excellence" ];then
    echo -e "\n2017" >> index.md
    echo -e "----\n" >> index.md

# Last post of 2018
elif [ "$blog_title" == "Gentoo Install Notes" ];then
    echo -e "\n2018" >> index.md
    echo -e "----\n" >> index.md
fi

echo -e "-   \[$brief_date\] [$blog_title]($blog_page)" >> index.md

# ADD THE POST TO THE RSS FEED
echo -e "<item>" >> html/rss.xml
echo -e "<title>$blog_title</title>" >> html/rss.xml
echo -e "<guid>https://tahaazzaoui.com/blog/$blog_page</guid>" >> html/rss.xml
echo -e "<pubDate>$blog_date</pubDate>" >> html/rss.xml
echo -e "<description><![CDATA[" >> html/rss.xml
cat $blog_page_tmp >> html/rss.xml
echo -e "]]></description>" >> html/rss.xml
echo -e "</item>" >> html/rss.xml

rm $blog_page_tmp
