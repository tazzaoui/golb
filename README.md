### The Simple Steps
1. Write a bunch of blog posts in markdown (in vim of course) in the `src` directory
2. Run `./genmake.sh` from the root directory to automatically generate a Makefile
3. Run `make` to compile the Markdown into HTML and build the table of contents & rss.xml
4. Run `make upload` to upload the files to the web server
