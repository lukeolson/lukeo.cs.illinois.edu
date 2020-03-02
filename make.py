#!/usr/bin/env python3
import io
import os
import time
import yaml
import shutil
import yaml
from codecs import open
import makebib
from jinja2 import Environment, FileSystemLoader


def formatbib(entry):
    """
    reformat to 80 charachters, keeping alignment with = {
    """
    import textwrap
    n = 80

    lines = entry.split('\n')

    newlines = []
    for line in lines:
        if len(line) > n:
            # wrap the text to n
            multiline = textwrap.wrap(line, n)

            # preserve the top line and determine the { location
            topline = multiline[0]
            padlength = topline.find('{') + 1

            # rewrap the rest knowing the indent length
            multiline = multiline[1:]
            multiline = ' '.join(multiline)
            multiline = textwrap.wrap(multiline, n - padlength)

            # padd and join
            padding = '\n' + ' ' * padlength
            newline = padding.join([topline]+multiline)
            newlines.append(newline)
        else:
            newlines.append(line)
    return '\n'.join(newlines)

# files = ['index.mako', 'research.mako', 'teaching.mako']
#
# for f in files:
#     fo = './live-old/' + f.strip('.mako') + '.html'
#     with open(f, 'r') as fin, open(fo, 'w') as fout:
#         print("generating %s -> %s" % (f, fo))
#         lookup = TemplateLookup(["."])
#         template = Template(fin.read(), lookup=lookup, output_encoding='utf8')
#         fout.write(template.render())


jinja_env = Environment(
    keep_trailing_newline=False,
    lstrip_blocks=True,
    trim_blocks=True,
    autoescape=False,
    loader=FileSystemLoader(os.path.abspath('.'))
)

# make the live web directory if needed
# move old to a timestamp just in case
liveweb = './live'

if os.path.exists(liveweb):
    timestamp = time.strftime('%c').replace(' ', '-').replace(':', '.')
    shutil.move(liveweb, liveweb+'-'+timestamp)

os.makedirs(liveweb)

# parse, render each template here
files = ['_index.html', '_research.html', '_teaching.html']

pubs = makebib.generate_pubs('refs.bib')
pubsexclude = ['2015_DaOlMiGa_partition']
pubs = [p for p in pubs if p['id'] not in pubsexclude]

for p in pubs:
    if 'pdf' not in p:
        pdfpath = './files/' + p['id'] + '.pdf'
        if os.path.exists(pdfpath):
            p['pdf'] = pdfpath
        else:
            print('No pdf found for %s' % p['id'])

    p['bibtex'] = formatbib(p['bibtex'])


with open("students.yml", "r", encoding="utf-8") as inf:
    students = yaml.load(inf, Loader=yaml.FullLoader)
    currentstudents = [s for s in students if s['category'] == 'current' or s['category'] == 'postdoc']

with open("resimg.yml", "r", encoding="utf-8") as inf:
    resimg = yaml.load(inf, Loader=yaml.FullLoader)

with open("courses.yml", "r", encoding="utf-8") as inf:
    courses = yaml.load(inf, Loader=yaml.FullLoader)
    courses = courses[1:]

# now render the pages
for f in files:
    template_vars = {}
    template_vars['pubs'] = pubs
    template_vars['students'] = students
    template_vars['currentstudents'] = currentstudents
    template_vars['resimg'] = resimg
    template_vars['courses'] = courses

    template = jinja_env.get_template(f)
    html = template.render(template_vars)
    with io.open(os.path.join('./live/', f[1:]), 'w', encoding='utf8') as fout:
        fout.write(html)

# copy these directories as-is to the webdir
livedirs = ['css', 'images', 'resimg', 'spgemmdata', 'files']
for d in livedirs:
    if os.path.isdir(d):
        shutil.copytree(d, os.path.join(liveweb, d))

# copy these files as-is to the webdir
livefiles = ['robots.txt']
for f in livefiles:
    shutil.copyfile(f, os.path.join(liveweb, f))
