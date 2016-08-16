#!/usr/local/bin/python

import re
import os

refsbib = open('refs.bib', 'r').read()
p = re.compile('@.+{(.*),')
g = p.findall(refsbib)

for f in g:
    name = f + '.pdf'
    if os.path.isfile(os.path.join('./live/files/', name)):
        print("[OK] %s ready" % f)
    else:
        print("[--] %s not found" % f)
