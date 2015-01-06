<%inherit file="base.mako"/>

<%block name="extra_header">
</%block>

<%block name="title">
  Luke Olson @ Illinois
</%block>

<%block name="full_content">

<%
import bibtexparser
pubs, orderedkeys = bibtexparser.generate_pubs('refs.bib')
%>

  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <div class="well">
          <p class="lead">
            I am Luke Olson
          </p>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
      <ul class="list-group">
      %for key in orderedkeys:
        <li class="list-group-item">
          ${pubs[key]["html"]}
        </li>
      %endfor
      </ul>
      </div>
    </div>
  </div>

        <span class="bibtex">[<a style="cursor:pointer;" title="Show BibTeX entry">BibTeX</a>]
          <div class="bibtex-body" style="display:none">
            <pre>
@article{somekey,
    author = "Some Author",
    title = "Some Title",
    journal = "Some Journal",
    url = "http://www.google.com",
    year = "2014",
}
</pre>
          </div>
        </span>

  <%block name="extra_scripts">
  </%block>
</%block>
