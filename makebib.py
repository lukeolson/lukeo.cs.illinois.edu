"""
this is a hack to generate html + bibtex entries
"""

import bibtexparser
from bibtexparser.bparser import BibTexParser
import bibtexparser.customization as cst

# list all fields and in which order they should appear in the printed bibtex
allfields0 = ['author',
             'title',
             'journal',
             'year',
             'address',
             'annote',
             'booktitle',
             'chapter',
             'edition',
             'editor',
             'eprint',
             'howpublished',
             'institution',
             'key',
             'month',
             'volume',
             'note',
             'number',
             'organization',
             'pages',
             'publisher',
             'school',
             'series']

alltypes = ['techreport', 'article', 'inproceedings', 'incollection',
            'phdthesis']


def cust(rec):
    rec = cst.author(rec)
    return rec


def tex2html(tex, styling=None):
    """
    simple translator from LaTeX to HTML:
        - $$ -> <i></i> if styling not 'it'
        - \& -> &amp;
        - \rm -> ''
        - -- -> -
        - finally, get rid of {}
        - change styling of full string

    should use regex if more complicated...
    """

    while '$' in tex:
        if styling != 'it':
            tex = tex.replace('$', '<span style="font-style: italics;">', 1)
        else:
            tex = tex.replace('$', '<span style="font-style: normal;">', 1)
        tex = tex.replace('$', '</span>', 1)

    while '\&' in tex:
        tex = tex.replace('\&', '&amp;')

    while '--' in tex:
        tex = tex.replace('--', '-')

    while '\rm' in tex:
        tex = tex.replace('\rm', '')

    while '{' in tex:
        tex = tex.replace('{', '')

    while '}' in tex:
        tex = tex.replace('}', '')

    if 'Olson' in tex:
        tex = '<span style="font-weight: bold;">' + tex + '</span>'

    if styling == 'it':
        html = '<span style="font-style: italic;">' + tex + '</span>'
    elif styling == 'sc':
        html = '<span style="font-variant: small-caps;">' + tex + '</span>'
    elif styling == 'paren':
        html = '(' + tex + ')'
    else:
        html = '<span style="font-style: normal;">' + tex + '</span>'

    return html


def whichfields(bibtype, style='siam'):

    if style == 'siam':
        """
        kind of mimics the siam.bst
        """
        if bibtype == 'article':
            allfields = ['author', 'title', 'journal', 'volume', 'year', 'pages', 'note']
        elif bibtype == 'techreport':
            allfields = ['author', 'title', 'number', 'institution', 'address', 'month', 'year', 'note']
        elif (bibtype == 'inproceedings') or (bibtype == 'incollection'):
            allfields = ['author', 'title', 'booktitle', 'volume', 'number',
                         'address', 'organization', 'publisher', 'year', 'note']
        elif bibtype == 'phdthesis':
            allfields = ['author', 'title', 'school', 'address', 'month', 'year', 'note']
        elif bibtype == 'inbook':
            allfields = ['author', 'title', 'chapter', 'bookeditor', 'publisher', 'year', 'note']
        else:
            allfields = allfields0

    styling = {}
    styling['author'] = 'sc'  # small caps
    styling['title'] = 'it'  # italic
    styling['note'] = 'it'  # italic

    return allfields, styling


def generate_bibtex(entry, bibid, bibtype):
    bibtex = '@%s{%s,\n' % (bibtype, bibid)

    for field in allfields0:
        if field in entry:
            e = entry[field]
            if field == 'author':
                e = ' and '.join(e)

            # right justify the field 16 characters
            # add the entry
            bibtex += '%s = {%s},\n' % (field.rjust(16), e)

    bibtex += '}'

    return bibtex


def generate_html(entry, bibid, bibtype, style='siam'):

    allfields, styling = whichfields(bibtype, style)

    html = ''
    for field in allfields:
        if field in entry:
            s = None
            tex = entry[field]
            if field in styling:
                s = styling[field]
            if field == 'author':
                for tex in entry[field]:
                    html += tex2html(tex, s) + ', '
            elif (field == 'year') and ('volume' in entry):
                html += entry['volume'] + ' (' + tex + '), '
            elif (field == 'volume') and ('year' in entry):
                pass
            else:
                html += tex2html(tex, s) + ', '

    return html[:-2] + '.'


def generate_pubs(bibfile):
    """
        - parse the bibfile
        - transform each entry into an html string
        - keep pdf, doi, url separate if available

    Create a list of pubs:
        'id'     : bib key
        'type'   : pub type
        'year'   : year of bib (for sorting I guess)
        'bibtex' : raw bibtex text
        'html'   : formatted text
        'pdf'    : path/to/localpaper.pdf
        'doi'    : doi
        'url'    : some url
    """

    with open(bibfile) as bibtex_file:
        parser = BibTexParser()
        parser.customization = cust
        parser.homogenise_fields = False
        rawdata = bibtexparser.load(bibtex_file, parser=parser).entries

    pubs = []
    for rawentry in rawdata:
        entry = {}

        if 'pdf' in rawentry:
            print(rawentry)
        # first three: id, type, year
        entry['id'] = rawentry.pop('ID')
        entry['type'] = rawentry.pop('ENTRYTYPE')
        if 'year' in rawentry:
            entry['year'] = rawentry['year']

        # generate raw bibtex string
        entry['bibtex'] = generate_bibtex(rawentry, entry['id'], entry['type'])

        # generate html string
        entry['html'] = generate_html(rawentry, entry['id'], entry['type'])

        # pdf
        # doi
        # url
        extrafields = ['pdf', 'doi', 'url']
        for field in extrafields:
            if field in rawentry:
                entry[field] = rawentry[field]
        pubs.append(entry)

    return pubs

if __name__ == '__main__':
    pubs = generate_pubs('refs.bib')
