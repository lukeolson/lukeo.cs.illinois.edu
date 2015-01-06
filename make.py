#!/usr/local/bin/python

# Mako script to generate live

from mako.template import Template
from mako.lookup import TemplateLookup

files = ['index.mako', 'research.mako']

for f in files:
    fo = './live/' + f.strip('.mako') + '.html'
    with open(f, 'r') as fin, open(fo, 'w') as fout:
        lookup = TemplateLookup(["."])
        template = Template(fin.read(), lookup=lookup, output_encoding='utf8')
        fout.write(template.render())
