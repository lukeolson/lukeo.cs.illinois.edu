from pybtex.database.input.bibtex import Parser
from pybtex.database.output.bibtex import Writer
from pybtex.database import BibliographyData
from pybtex.backends import html
from pybtex.style.formatting import plain, unsrt
from StringIO import StringIO

"""
Creates a dictionary of pubs:
    'key'    : bib key (force lowercase)
    'year'   : year of bib (for sorting)
    'bibtex' : bibtex raw text
    'html'   : formatted text
    'pdf'    : path/to/localpaper.pdf
    'doi'    : doi
    'url'    : some url

see:
https://github.com/andreas-h/pelican-bibtex/blob/3d69cddfc48fcb044c19d0804db26b70e8e00194/pelican_bibtex.py#L81

- depends on pybtex
- pybtex parser returns keys in an ordered dict
- pubs: dictionary of entries
- orderedkeys: list of keys for the dictionary
"""


def generate_pubs(bibfile):
    p = Parser()
    style = plain.Style()
    style = unsrt.Style()

    # blank out the url, doi, etc in the actual entry.  Add later.
    def blank(e):
        return ''
    style.format_web_refs = blank

    # parse bib file
    bibs = p.parse_file(bibfile)
    orderedkeys = bibs.entries.keys()
    formattedbibs = style.format_entries(bibs.entries.values())

    pubs = {}

    for bib in formattedbibs:
        bibtex = bibs.entries[bib.key]
        bibtexkeys = [k.lower() for k in bibtex.fields.keys()]
        year = bibtex.fields.get('year')
        pdf = bibtex.fields.get('pdf') if 'pdf' in bibtexkeys else None
        doi = bibtex.fields.get('doi') if 'doi' in bibtexkeys else None
        url = bibtex.fields.get('url') if 'url' in bibtexkeys else None

        f = StringIO()
        bibdata = BibliographyData(entries={bib.key: bibtex})
        Writer().write_stream(bibdata, f)
        bibtexraw = f.getvalue()
        print bib.text
        break
        htmltext = bib.text.render(html.Backend())

        pubs[bib.key] = {'year': year,
                         'bibtex': bibtexraw,
                         'html': htmltext,
                         'pdf': pdf,
                         'doi': doi,
                         'url': url}
    return pubs, orderedkeys


def print_pubs(pubs, orderedkeys):
    print pubs.keys()
    for key in orderedkeys:
        print pubs[key]['year']
