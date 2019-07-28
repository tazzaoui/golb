#!/usr/bin/env python3

import os
import time
from datetime import datetime as dt
import subprocess as sp

def get_title(file_path):
    with open(file_path, "r") as f:
        for line in f.readlines():
            if "title:" in line.lower():
                title = line.split(" ")[1:]
                return " ".join(title).strip()

def get_date(file_path):
    with open(file_path, "r") as f:
        for line in f.readlines():
            if "date:" in line.lower():
                date = line.split(" ")[1].strip()
                return date.replace("-", ".")

def filter_lines(file_path, date, title):
    with open(file_path, "r") as f:
        lines = f.readlines()

    with open(file_path, "w") as f:
        for line in lines:
            if "TITLE" in line:
                f.write(line.replace("TITLE-HERE", title))
            elif "DATE" in line:
                f.write(line.replace("DATE-HERE", date))
            elif "HTML-FILE" in line:
                f.write(line.replace("HTML-FILE-HERE", os.path.basename(file_path)))
            elif "POST-HERE" in line:
                f.write(line.replace("POST-HERE", title.replace(" ", "-")))
            elif "<!-- MATHJAX HERE -->" in line:
                with open("utils/mathjax.html") as m:
                    for mline in m.readlines():
                        f.write(mline)
            elif "<!-- NAVBAR HERE -->" in line:
                with open("utils/navbar.html") as n:
                    for nline in n.readlines():
                        f.write(nline)
            else:
                f.write(line)

def md_to_html(file_path):
    title = get_title(file_path)
    date = get_date(file_path)
    file_name = os.path.basename(file_path)
    out_path = file_name[:-3] + ".html"
    full_out_path = os.path.join("html", out_path)
    cmd = "pandoc --ascii -t html5 {} -o {}".format(file_path, full_out_path)
    sp.call(cmd.split(), stdout=sp.DEVNULL, stderr=sp.DEVNULL)

    with open(full_out_path, "r") as f:
        lines = f.readlines()

    with open(full_out_path, "w") as f:
        with open("utils/header.html", "r") as h:
            for line in h.readlines():
                f.write(line)
        with open("utils/article.html", "r") as a:
            for line in a.readlines():
                f.write(line)
        for line in lines:
            f.write(line)
        f.write("\n</article>")
        with open("utils/footer.html", "r") as footer:
            for line in footer.readlines():
                f.write(line)

    filter_lines(full_out_path, date, title)

    cmd = "tidy -q -i -m -w 120 -ashtml -utf8 --tidy-mark no {}".format(full_out_path)
    sp.call(cmd.split(), stdout=sp.DEVNULL, stderr=sp.DEVNULL)
    return (date, title, out_path)

def gen_index(index):
    with open("html/index.html", "w") as i:

        with open("utils/header.html", "r") as f:
            for line in f.readlines():
                i.write(line)

        with open("utils/archive.html", "r") as f:
            for line in f.readlines():
                i.write(line)

        for year in sorted(index.keys(), reverse=True):
            i.write("<h2>{}</h2>\n<ul>\n".format(year))
            for (d, t, o) in index[year]:
                i.write('<li>[{}] <a href="{}">{}</a></li>\n'.format(d, o, t))
            i.write("</ul>\n")

        with open("utils/footer.html", "r") as f:
            for line in f.readlines():
                i.write(line)

    filter_lines("html/index.html", None, "Archive")

def gen_rss(index):
    with open("html/rss.xml", "w") as rss:

        with open("utils/rss-header.html", "r") as f:
            for l in f.readlines():
                rss.write(l)

        for year in sorted(index.keys(), reverse=True):
            for (d, t, o) in index[year]:
                base_path = os.path.basename(o)
                rss.write("<item>\n")
                rss.write("<title>{}</title>\n".format(t))
                rss.write("<guid>https://azzaoui.org/blog/{}</guid>\n".format(base_path))
                rss.write("<pubDate>{}</pubDate>\n".format(d))
                rss.write("<description> Post: https://azzaoui.org/blog/{} </description>\n".format(base_path))
                rss.write("</item>\n")

        rss.write("</channel>\n</rss>\n")
if __name__ == "__main__":
    sp.call("mkdir -p html".split())
    sp.call("rm -f html/*.html".split())
    index = {}

    for f in os.listdir("src"):
        f = os.path.join("src", f)
        if f.split(".")[-1] == "md":
           (d, t, o) = md_to_html(f)
           year = d.split(".")[0]
           if year not in index:
               index[year] = []
           index[year].append((d, t, o))
           print("{} -> {}".format(f, o))

    for year in sorted(index.keys(), reverse=True):
        posts = [(dt.strptime(d, "%Y.%m.%d"), t, o) for (d,t,o) in index[year]]
        posts = sorted(posts, reverse=True)
        posts = [(dt.strftime(d, "%Y.%m.%d"), t, o) for (d, t, o) in posts]
        index[year] = posts

    gen_index(index)
    gen_rss(index)
